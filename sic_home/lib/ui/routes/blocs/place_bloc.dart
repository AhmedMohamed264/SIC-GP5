import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/models/create_section_model.dart';
import 'package:sic_home/models/user.dart';
import 'package:sic_home/repositories/authentication_repository.dart';
import 'package:sic_home/repositories/sections_repository.dart';
import 'package:sic_home/repositories/users_repository.dart';
import 'package:sic_home/ui/routes/route_generator.dart';

enum PlaceStates { initial, loading, loaded, error }

class PlaceState {
  PlaceStates state;
  User user;
  String? error;

  PlaceState({
    required this.state,
    required this.user,
    this.error,
  });
}

class LoadEvent {}

class AddSectionEvent {
  final CreateSectionModel section;

  const AddSectionEvent(this.section);
}

class PlaceBloc extends Bloc<Object, PlaceState> {
  PlaceBloc(
      UsersRepository usersRepository, SectionsRepository sectionsRepository)
      : super(
          PlaceState(
            state: PlaceStates.initial,
            user:
                AuthenticationRepository().authenticationService.currentUser()!,
          ),
        ) {
    on<LoadEvent>(
      (event, emit) async {
        emit(PlaceState(
          state: PlaceStates.loading,
          user: state.user,
        ));

        await usersRepository.getUserById(state.user.id).then(
          (user) {
            emit(PlaceState(
              state: PlaceStates.loaded,
              user: user,
            ));
          },
          onError: (error) {
            emit(
              PlaceState(
                state: PlaceStates.error,
                user: state.user,
                error: error.toString(),
              ),
            );
          },
        );
      },
    );

    on<AddSectionEvent>(
      (event, emit) async {
        RouteGenerator.mainNavigatorkey.currentState
            ?.pop(); // Close the add place dialog.

        emit(PlaceState(
          state: PlaceStates.loading,
          user: state.user,
        )); // Show loading dialog.

        await sectionsRepository.createSection(event.section).then(
          (place) {
            emit(PlaceState(
              state: PlaceStates.loaded,
              user: state.user,
            ));
          },
          onError: (error) {
            emit(
              PlaceState(
                state: PlaceStates.error,
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
