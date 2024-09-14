import 'dart:developer';

import 'package:sic_home/apis/authentication/interfaces/iauthentication.dart';
import 'package:sic_home/apis/authentication/interfaces/iauthentication_api.dart';
import 'package:sic_home/apis/authentication/token_manager.dart';
import 'package:sic_home/models/authentication/login_model.dart';
import 'package:sic_home/models/authentication/register_model.dart';
import 'package:sic_home/models/user.dart';
import 'package:sic_home/repositories/interfaces/i_users_repository.dart';

class Authentication implements IAuthentication {
  final IAuthenticationApi _authenticationApi;
  final IUsersRepository _usersRepository;

  final TokenManager _tokenManager = TokenManager();

  User? _currentUser;

  Authentication(this._authenticationApi, this._usersRepository);

  @override
  Future<User?> registerAndLogin(RegisterModel registerModel) async {
    log('Registering user ${registerModel.username}...',
        name: 'Authentication');
    var apiResponse = await _authenticationApi.register(registerModel);
    if (apiResponse) {
      return signIn(LoginModel(
          username: registerModel.username, password: registerModel.password));
    }

    return null;
  }

  @override
  Future<User?> signIn(LoginModel loginModel) async {
    log('Logging in user ${loginModel.username}...', name: 'Authentication');
    var tokens = await _authenticationApi.login(loginModel);
    if (tokens != null) {
      await _tokenManager.saveTokens(tokens);
      _currentUser =
          await _usersRepository.getUserById(tokens.getIdFromAccessToken());
      return _currentUser;
    }

    return null;
  }

  @override
  Future signOut() {
    log('Signing out...', name: 'Authentication');
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future sendPasswordResetEmail(User user) {
    log('Sending password reset email to ${user.userName}...',
        name: 'Authentication');
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<User?> loadUser() async {
    log('Loading user...', name: 'Authentication');
    var savedTokens = await _tokenManager.readSavedTokens();
    if (savedTokens == null) {
      return null;
    } else if (savedTokens.isAccessTokenExpired()) {
      var newTokens = await _tokenManager.refreshTokens();
      if (newTokens == null) {
        return null;
      }
    }

    _currentUser =
        await _usersRepository.getUserById(savedTokens.getIdFromAccessToken());

    return _currentUser;
  }

  @override
  User? currentUser() {
    log('Getting current user...', name: 'Authentication');
    return _currentUser;
  }

  @override
  Future<User?> signInWithGoogle() {
    log('Signing in with Google...', name: 'Authentication');
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<bool> isUserValid(User user) {
    log('Checking if user is valid...', name: 'Authentication');
    // TODO: implement isUserValid
    return Future.value(true);
  }
}
