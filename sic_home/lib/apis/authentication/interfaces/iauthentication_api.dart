import 'package:sic_home/models/authentication/login_model.dart';
import 'package:sic_home/models/authentication/register_model.dart';
import 'package:sic_home/models/authentication/tokens_model.dart';

abstract class IAuthenticationApi {
  Future<bool> register(RegisterModel registerModel);

  Future<TokensModel?> login(LoginModel loginModel);

  Future signOut();
}
