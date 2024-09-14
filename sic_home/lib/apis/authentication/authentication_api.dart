import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:sic_home/apis/authentication/interfaces/iauthentication_api.dart';
import 'package:sic_home/config.dart';
import 'package:sic_home/models/authentication/login_model.dart';
import 'package:sic_home/models/authentication/register_model.dart';
import 'package:sic_home/models/authentication/tokens_model.dart';

class AuthenticationApi implements IAuthenticationApi {
  final dioClient = Dio();

  AuthenticationApi._() {
    (dioClient.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      var client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dioClient.options.baseUrl = '${Config().api}/Auth';
  }

  static final AuthenticationApi _instance = AuthenticationApi._();

  factory AuthenticationApi() => _instance;

  @override
  Future<bool> register(RegisterModel registerModel) async {
    log('Registering user ${registerModel.username}...',
        name: 'AuthenticationApi');
    var response =
        await dioClient.post('/Register', data: registerModel.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return true;
    }

    return false;
  }

  @override
  Future<TokensModel?> login(LoginModel loginModel) async {
    log('Logging in user ${loginModel.username}...', name: 'AuthenticationApi');
    var response = await dioClient.post<Map<String, dynamic>>('/Login',
        data: loginModel.toJson());

    if (response.statusCode == 200) {
      return TokensModel.fromJson(response.data!);
    }

    return null;
  }

  @override
  Future signOut() {
    log('Signing out...', name: 'AuthenticationApi');
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
