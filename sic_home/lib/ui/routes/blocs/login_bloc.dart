import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/apis/authentication/exceptions/authentication_exception.dart';
import 'package:sic_home/models/authentication/login_model.dart';
import 'package:sic_home/models/user.dart';
import 'package:sic_home/repositories/authentication_repository.dart';
import 'package:sic_home/ui/routes/route_generator.dart';

enum SignInStates { startup, loading, failed, success }

class SignInState {
  SignInStates state;
  String? error;
  User? userCredential;

  SignInState({required this.state, this.error, this.userCredential});
}

class EmailLoginEvent {
  String email;
  String password;

  EmailLoginEvent({required this.email, required this.password});
}

class GoogleLoginEvent {}

class LoginBloc extends Bloc<Object, SignInState> {
  LoginBloc() : super(SignInState(state: SignInStates.startup)) {
    on<GoogleLoginEvent>(
      (event, emit) async {
        emit(SignInState(state: SignInStates.loading));
        try {
          await AuthenticationRepository()
              .authenticationService
              .signInWithGoogle();
          RouteGenerator.mainNavigatorkey.currentState!.pushNamedAndRemoveUntil(
            RouteGenerator.homePage,
            (route) => false,
          );
        } on AuthenticationException catch (e) {
          emit(
            SignInState(
              state: SignInStates.failed,
              error: e.message,
            ),
          );
        } catch (e) {
          emit(
            SignInState(
              state: SignInStates.failed,
              error: 'something\'s gone wrong :(\n${(e)}',
            ),
          );
        }
      },
    );
    on<EmailLoginEvent>(
      (event, emit) async {
        emit(SignInState(state: SignInStates.loading));
        if (event.email.isNotEmpty && event.password.isNotEmpty) {
          try {
            SignInState? state;
            final user = await AuthenticationRepository()
                .authenticationService
                .signIn(LoginModel(
                    username: event.email, password: event.password));
            log('Finished signing in', name: 'LoginBloc');
            state ??= SignInState(
              state: SignInStates.success,
              userCredential: user,
            );
            if (state.state == SignInStates.success) {
              RouteGenerator.mainNavigatorkey.currentState!
                  .pushNamedAndRemoveUntil(
                RouteGenerator.homePage,
                (route) => false,
              );
            }
          } on AuthenticationException catch (e) {
            // rethrow;
            emit(
              SignInState(
                state: SignInStates.failed,
                error: e.message,
              ),
            );
          } catch (e) {
            emit(
              SignInState(
                state: SignInStates.failed,
                error: 'something\'s gone wrong :( \n${(e)}',
              ),
            );
          }
        } else {
          emit(
            SignInState(
              state: SignInStates.failed,
              error: "Invalid or no input.",
            ),
          );
        }
      },
    );
  }
}
