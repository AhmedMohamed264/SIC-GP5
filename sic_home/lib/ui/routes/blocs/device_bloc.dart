import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/config.dart';
import 'package:sic_home/models/device.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

enum DeviceStates { initial, loading, loaded, error }

class DeviceState {
  DeviceStates state;
  String data;
  String error;

  DeviceState({
    required this.state,
    required this.data,
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

class DeviceBloc extends Bloc<Object, DeviceState> {
  final Device device;
  late HubConnection hubConnection;
  DeviceBloc(this.device)
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

        await hubConnection.invoke('SubscribeToDevice',
            args: [hubConnection.connectionId!, event.pin]);

        // hubConnection.on('ReceiveData', (arguments) {
        //   // log(arguments.toString());
        //   // log((arguments![0] as int).toString());
        //   // add(DataReceivedEvent<int>(arguments[0] as int));

        //   if (arguments![0] is int) {
        //     add(DataReceivedEvent<int>(arguments[0] as int));
        //   } else if (arguments[0] is double) {
        //     add(DataReceivedEvent<double>(arguments[0] as double));
        //   } else if (arguments[0] is String) {
        //     add(DataReceivedEvent<String>(arguments[0] as String));
        //   } else if (arguments[0] is bool) {
        //     add(DataReceivedEvent<bool>(arguments[0] as bool));
        //   }
        // });

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
        emit(
          DeviceState(
            state: DeviceStates.loaded,
            data: event.data,
            error: '',
          ),
        );
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
