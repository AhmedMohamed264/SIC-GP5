import 'package:dio/dio.dart';
import 'package:sic_home/apis/users_api.dart';
import 'package:sic_home/models/authentication/notification_token.dart';
import 'package:sic_home/models/user.dart';
import 'package:sic_home/repositories/interfaces/i_users_repository.dart';

class UsersRepository implements IUsersRepository {
  final UsersApi _usersApi = UsersApi(Dio());

  @override
  Future<bool> isUserNameAvailable(String userName) async {
    return await _usersApi.isUserNameAvailable(userName);
  }

  @override
  Future<List<NotificationToken>> getNotificationTokens(String userId) async {
    return await _usersApi.getNotificationTokens(userId);
  }

  @override
  Future<User> getUserByUserName(String userName) async {
    return await _usersApi.getUserByUserName(userName);
  }

  @override
  Future<User> getUserById(int id) async {
    return await _usersApi.getUser(id);
  }
}
