import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/config.dart';
import 'package:sic_home/models/device.dart';
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

class DataReceivedEvent<T> {
  final T data;

  const DataReceivedEvent(this.data);
}

class DeviceBloc extends Bloc<Object, DeviceState> {
  final Device device;
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
        final hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
        await hubConnection.start();
        log('Connection started');

        await hubConnection.invoke('SubscribeToDevice',
            args: [hubConnection.connectionId!, event.pin]);

        hubConnection.on('ReceiveData', (arguments) {
          log((arguments![0] as int).toString());
          add(DataReceivedEvent<int>(arguments[0] as int));
        });
      },
    );

    on<DataReceivedEvent<int>>(
      (event, emit) {
        emit(
          DeviceState(
            state: DeviceStates.loaded,
            data: event.data.toString(),
            error: '',
          ),
        );
      },
    );

    add(SubscribeToDeviceEvent(device.pin.toString()));
  }
}
