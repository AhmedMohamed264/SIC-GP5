import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/config.dart';
import 'package:sic_home/repositories/authentication_repository.dart';
import 'package:sic_home/ui/routes/route_generator.dart';

enum StartupStates {
  loading,
  loaded,
  error,
}

class StartupCompleted {}

class StartupBloc extends Bloc<Object, Object> {
  StartupBloc() : super(0) {
    on<StartupCompleted>(
      (event, emit) async {
        if (AuthenticationRepository().authenticationService.currentUser() ==
            null) {
          RouteGenerator.mainNavigatorkey.currentState!
              .pushReplacementNamed(RouteGenerator.loginPage);
        } else {
          if (await AuthenticationRepository()
              .authenticationService
              .isUserValid(AuthenticationRepository()
                  .authenticationService
                  .currentUser()!)) {
            RouteGenerator.mainNavigatorkey.currentState!
                .pushReplacementNamed(RouteGenerator.homePage);
          } else {
            AuthenticationRepository().authenticationService.signOut();
            RouteGenerator.mainNavigatorkey.currentState!
                .pushReplacementNamed(RouteGenerator.loginPage);
          }
        }
      },
    );

    initializeApp();
  }

  Future initializeApp() async {
    await Config.load();
    // late final Future<FirebaseApp> initialization;
    // initialization =
    //     Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // await initialization;
    await AuthenticationRepository().authenticationService.loadUser();

    // late notification_token.Platform platform;
    // if (Platform.isAndroid) {
    //   platform = notification_token.Platform.android;
    // } else if (Platform.isIOS) {
    //   platform = notification_token.Platform.ios;
    // } else if (kIsWeb) {
    //   platform = notification_token.Platform.web;
    // }

    // if (!kIsWeb) {
    //   // until adding the vapid key for web support.
    //   // String fcmToken = await FCM().init();

    //   if (AuthenticationRepository().authenticationService.currentUser() !=
    //       null) {
    //     notification_token.NotificationToken notificationToken =
    //         notification_token.NotificationToken(
    //       token: fcmToken,
    //       userId: AuthenticationRepository()
    //           .authenticationService
    //           .currentUser()!
    //           .id,
    //       platform: platform,
    //     );

    //     await TokenManager().saveNotificationToken(notificationToken);
    //   }
    // }

    add(StartupCompleted());
  }
}
