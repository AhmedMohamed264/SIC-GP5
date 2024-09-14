import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/apis/authentication/exceptions/authentication_exception.dart';
import 'package:sic_home/models/authentication/register_model.dart';
import 'package:sic_home/models/user.dart';
import 'package:sic_home/repositories/authentication_repository.dart';

enum RegisterStates { startup, loading, failed, success }

class RegisterState {
  RegisterStates previouseState;
  RegisterStates state;
  String? error;
  User? userCredential;

  RegisterState(
      {required this.previouseState,
      required this.state,
      this.error,
      this.userCredential});
}

class RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final bool gender;
  final String password;
  final String confirmPassword;

  const RegisterEvent(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.userName,
      required this.gender,
      required this.password,
      required this.confirmPassword});
}

class RegisterBloc extends Bloc<Object, RegisterState> {
  RegisterBloc()
      : super(RegisterState(
            previouseState: RegisterStates.startup,
            state: RegisterStates.startup)) {
    on<RegisterEvent>(
      (event, emit) async {
        if (event.firstName.isNotEmpty &&
            event.lastName.isNotEmpty &&
            event.email.isNotEmpty &&
            event.userName.isNotEmpty &&
            event.password.isNotEmpty &&
            event.confirmPassword.isNotEmpty &&
            event.password == event.confirmPassword) {
          try {
            emit(
              RegisterState(
                previouseState: state.state,
                state: RegisterStates.loading,
              ),
            );
            final user = await AuthenticationRepository()
                .authenticationService
                .registerAndLogin(
                  RegisterModel(
                    firstName: event.firstName,
                    lastName: event.lastName,
                    email: event.email,
                    username: event.userName,
                    password: event.password,
                  ),
                );
            // await user.user
            //     ?.updateDisplayName("${event.firstName} ${event.lastName}");
            emit(
              RegisterState(
                previouseState: state.state,
                state: RegisterStates.success,
                userCredential: user,
              ),
            );
          } on EmailInUseException catch (_) {
            emit(
              RegisterState(
                previouseState: state.state,
                state: RegisterStates.failed,
                error: "Email already in use",
              ),
            );
          } on InvalidEmailException catch (_) {
            emit(
              RegisterState(
                previouseState: state.state,
                state: RegisterStates.failed,
                error: "Invalid email",
              ),
            );
          } on WeakPasswordException catch (_) {
            emit(
              RegisterState(
                previouseState: state.state,
                state: RegisterStates.failed,
                error: "Weak password",
              ),
            );
          } on AuthenticationException catch (e) {
            emit(
              RegisterState(
                previouseState: state.state,
                state: RegisterStates.failed,
                error: "something's gone wrong :(\n${e.code}",
              ),
            );
          } catch (e) {
            emit(
              RegisterState(
                previouseState: state.state,
                state: RegisterStates.failed,
                error: "something's gone wrong :(\n${e.runtimeType}",
              ),
            );
          }
        } else {
          emit(
            RegisterState(
              previouseState: state.state,
              state: RegisterStates.failed,
              error: "invalid or no input",
            ),
          );
        }
      },
    );
  }
}
