import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/models/create_device_model.dart';
import 'package:sic_home/models/user.dart';
import 'package:sic_home/repositories/authentication_repository.dart';
import 'package:sic_home/repositories/devices_repository.dart';
import 'package:sic_home/repositories/users_repository.dart';
import 'package:sic_home/ui/routes/route_generator.dart';

enum SectionStates { initial, loading, loaded, error }

class SectionState {
  SectionStates state;
  User user;
  String? error;

  SectionState({
    required this.state,
    required this.user,
    this.error,
  });
}

class LoadEvent {}

class AddDeviceEvent {
  final CreateDeviceModel device;

  const AddDeviceEvent(this.device);
}

class SectionBloc extends Bloc<Object, SectionState> {
  SectionBloc(
      UsersRepository usersRepository, DevicesRepository decvicesRepository)
      : super(
          SectionState(
            state: SectionStates.initial,
            user:
                AuthenticationRepository().authenticationService.currentUser()!,
          ),
        ) {
    on<LoadEvent>(
      (event, emit) async {
        emit(SectionState(
          state: SectionStates.loading,
          user: state.user,
        ));

        await usersRepository.getUserById(state.user.id).then(
          (user) {
            emit(SectionState(
              state: SectionStates.loaded,
              user: user,
            ));
          },
          onError: (error) {
            emit(
              SectionState(
                state: SectionStates.error,
                user: state.user,
                error: error.toString(),
              ),
            );
          },
        );
      },
    );

    on<AddDeviceEvent>(
      (event, emit) async {
        RouteGenerator.mainNavigatorkey.currentState
            ?.pop(); // Close the add Device dialog.

        emit(SectionState(
          state: SectionStates.loading,
          user: state.user,
        )); // Show loading dialog.

        await decvicesRepository.createDevice(event.device).then(
          (_) {
            emit(SectionState(
              state: SectionStates.loaded,
              user: state.user,
            ));
          },
          onError: (error) {
            emit(
              SectionState(
                state: SectionStates.error,
                user: state.user,
                error: error.toString(),
              ),
            );
          },
        );

        add(LoadEvent());
      },
    );

    add(LoadEvent());
  }
}
