import 'package:sic_home/models/authentication/notification_token.dart';
import 'package:sic_home/models/user.dart';

abstract class IUsersRepository {
  Future<User> getUserById(String id);

  Future<User> getUserByUserName(String userName);

  Future<bool> isUserNameAvailable(String userName);

  Future<List<NotificationToken>> getNotificationTokens(String userId);
}
