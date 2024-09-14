import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:sic_home/models/authentication/notification_token.dart';
import 'package:sic_home/models/user.dart';

part 'users_api.g.dart';

@RestApi()
abstract class UsersApi {
  factory UsersApi(Dio dio) = _UsersApi;

  @GET('/{id}')
  Future<User> getUser(
    @Path('id') int id,
  );

  @GET('/UserName/{username}')
  Future<User> getUserByUserName(
    @Path('username') String userName,
  );

  @GET('/IsUserNameAvailable/{username}')
  Future<bool> isUserNameAvailable(
    @Path('username') String userName,
  );

  @GET('/NotificationTokens/{userId}')
  Future<List<NotificationToken>> getNotificationTokens(
    @Path('userId') String userId,
  );
}
