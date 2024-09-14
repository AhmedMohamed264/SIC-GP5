import 'package:sic_home/apis/authentication/authentication.dart';
import 'package:sic_home/apis/authentication/authentication_api.dart';
import 'package:sic_home/apis/authentication/interfaces/iauthentication.dart';
import 'package:sic_home/repositories/users_repository.dart';

class AuthenticationRepository {
  final IAuthentication authenticationService;

  const AuthenticationRepository._(this.authenticationService);

  static final _instance = AuthenticationRepository._(
      Authentication(AuthenticationApi(), UsersRepository()));

  factory AuthenticationRepository() => _instance;
}
