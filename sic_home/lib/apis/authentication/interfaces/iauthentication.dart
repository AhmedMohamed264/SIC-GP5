import 'package:sic_home/models/authentication/login_model.dart';
import 'package:sic_home/models/authentication/register_model.dart';
import 'package:sic_home/models/user.dart';

abstract class IAuthentication {
  Future<User?> registerAndLogin(RegisterModel registerModel);

  Future<User?> signIn(LoginModel loginModel);

  Future signOut();

  Future sendPasswordResetEmail(User user);

  Future<User?> loadUser();

  User? currentUser();

  Future<User?> signInWithGoogle();

  Future<bool> isUserValid(User user);
}
