import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/models/create_place_model.dart';
import 'package:sic_home/models/user.dart';
import 'package:sic_home/repositories/authentication_repository.dart';
import 'package:sic_home/repositories/places_repository.dart';
import 'package:sic_home/repositories/users_repository.dart';
import 'package:sic_home/ui/routes/route_generator.dart';

enum HomeStates { initial, loading, loaded, error }

class HomeState {
  HomeStates state;
  User user;
  String? error;

  HomeState({
    required this.state,
    required this.user,
    this.error,
  });
}

class LoadEvent {}

class AddPlaceEvent {
  final CreatePlaceModel place;

  const AddPlaceEvent(this.place);
}

class HomeBloc extends Bloc<Object, HomeState> {
  HomeBloc(UsersRepository usersRepository, PlacesRepository placesRepository)
      : super(
          HomeState(
            state: HomeStates.initial,
            user:
                AuthenticationRepository().authenticationService.currentUser()!,
          ),
        ) {
    on<LoadEvent>(
      (event, emit) {
        emit(HomeState(
          state: HomeStates.loading,
          user: state.user,
        ));

        usersRepository.getUserById(state.user.id).then(
          (user) {
            emit(HomeState(
              state: HomeStates.loaded,
              user: user,
            ));
          },
          onError: (error) {
            emit(
              HomeState(
                state: HomeStates.error,
                user: state.user,
                error: error.toString(),
              ),
            );
          },
        );
      },
    );

    on<AddPlaceEvent>(
      (event, emit) {
        RouteGenerator.mainNavigatorkey.currentState
            ?.pop(); // Close the add place dialog.

        emit(HomeState(
          state: HomeStates.loading,
          user: state.user,
        )); // Show loading dialog.

        placesRepository.createPlace(event.place).then(
          (place) {
            emit(HomeState(
              state: HomeStates.loaded,
              user: state.user,
            ));
          },
          onError: (error) {
            emit(
              HomeState(
                state: HomeStates.error,
                user: state.user,
                error: error.toString(),
              ),
            );
          },
        );

        add(LoadEvent());
      },
    );
  }
}
