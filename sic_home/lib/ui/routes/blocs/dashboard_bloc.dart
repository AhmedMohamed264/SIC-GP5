import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/models/device.dart';
import 'package:sic_home/repositories/authentication_repository.dart';
import 'package:sic_home/repositories/devices_repository.dart';

enum DashboardStates { initial, loading, loaded, error }

class DashboardState {
  DashboardStates state;
  List<Device> devices;
  String error;

  DashboardState({
    required this.state,
    required this.devices,
    required this.error,
  });
}

class LoadEvent {}

class DashboardBloc extends Bloc<Object, DashboardState> {
  DashboardBloc(DevicesRepository devicesRepository)
      : super(
          DashboardState(
            state: DashboardStates.initial,
            devices: [],
            error: '',
          ),
        ) {
    on<LoadEvent>(
      (event, emit) async {
        emit(
          DashboardState(
            state: DashboardStates.loading,
            devices: state.devices,
            error: '',
          ),
        );

        await devicesRepository
            .getDevicesByUser(
          AuthenticationRepository().authenticationService.currentUser()!.id,
        )
            .then(
          (devices) {
            emit(
              DashboardState(
                state: DashboardStates.loaded,
                devices: devices,
                error: '',
              ),
            );
          },
          onError: (error) {
            emit(
              DashboardState(
                state: DashboardStates.error,
                devices: state.devices,
                error: error.toString(),
              ),
            );
          },
        );
      },
    );
  }
}
