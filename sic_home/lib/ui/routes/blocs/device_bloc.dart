import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/config.dart';
import 'package:sic_home/models/device.dart';
import 'package:sic_home/models/user.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

enum DeviceStates { initial, loading, loaded, error }

class DeviceState {
  DeviceStates state;
  String data;
  double maxData;
  String error;

  DeviceState({
    required this.state,
    required this.data,
    this.maxData = 0,
    required this.error,
  });
}

class SubscribeToDeviceEvent {
  final String pin;

  const SubscribeToDeviceEvent(this.pin);
}

class DataReceivedEvent {
  final String data;

  const DataReceivedEvent(this.data);
}

class DeviceEvent {
  final String data;

  const DeviceEvent(this.data);
}

class DeviceBloc extends Bloc<Object, DeviceState> {
  final Device device;
  late HubConnection hubConnection;
  double maxData = 0;
  DeviceBloc(this.device, User user)
      : super(
          DeviceState(
            state: DeviceStates.initial,
            data: '',
            error: '',
          ),
        ) {
    on<SubscribeToDeviceEvent>(
      (event, emit) async {
        emit(
          DeviceState(
            state: DeviceStates.loading,
            data: '',
            error: '',
          ),
        );

        final serverUrl = '${Config().api}/DevicesDataHub';
        hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
        await hubConnection.start();
        log('Connection started');

        await hubConnection.invoke('SubscribeToDevice', args: [event.pin]);

        hubConnection.on('ReceiveData', (arguments) {
          if (arguments![0] is int) {
            log('is int');
          } else if (arguments[0] is double) {
            log('is double');
          } else if (arguments[0] is String) {
            log('is string');
          } else if (arguments[0] is bool) {
            log('is bool');
          }
          // print(arguments);
          log(arguments[0].toString());
          add(DataReceivedEvent(arguments[0].toString()));
        });
      },
    );

    on<DataReceivedEvent>(
      (event, emit) {
        maxData = maxData < double.parse(event.data)
            ? double.parse(event.data).ceilToDouble()
            : maxData; // Assign the max value
        emit(
          DeviceState(
            state: DeviceStates.loaded,
            data: event.data,
            maxData: maxData,
            error: '',
          ),
        );
      },
    );

    on<DeviceEvent>(
      (event, emit) {
        hubConnection.invoke('SendDeviceData', args: [device.pin, event.data]);
      },
    );

    add(SubscribeToDeviceEvent(device.pin.toString()));
  }

  @override
  Future<void> close() async {
    await hubConnection.stop();
    return super.close();
  }
}
