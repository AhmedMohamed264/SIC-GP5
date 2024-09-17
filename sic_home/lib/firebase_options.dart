// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD-SRi-l2-q-Wfu4saFufobv0f9vaf8fuY',
    appId: '1:877665265236:web:19699b301667235d572fc1',
    messagingSenderId: '877665265236',
    projectId: 'sic-home',
    authDomain: 'sic-home.firebaseapp.com',
    storageBucket: 'sic-home.appspot.com',
    measurementId: 'G-WHBQGZSK55',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBE4a7veg3zB-ekyM2HPb8gCU5wS3I6zv8',
    appId: '1:877665265236:android:7408b5161eef1aea572fc1',
    messagingSenderId: '877665265236',
    projectId: 'sic-home',
    storageBucket: 'sic-home.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdCDIBY77ZUhX9CoDDYksZSofRkLJsmrQ',
    appId: '1:877665265236:ios:8b51eb360c730387572fc1',
    messagingSenderId: '877665265236',
    projectId: 'sic-home',
    storageBucket: 'sic-home.appspot.com',
    iosBundleId: 'com.example.sicHome',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdCDIBY77ZUhX9CoDDYksZSofRkLJsmrQ',
    appId: '1:877665265236:ios:8b51eb360c730387572fc1',
    messagingSenderId: '877665265236',
    projectId: 'sic-home',
    storageBucket: 'sic-home.appspot.com',
    iosBundleId: 'com.example.sicHome',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-SRi-l2-q-Wfu4saFufobv0f9vaf8fuY',
    appId: '1:877665265236:web:aa7b3dec04f702e8572fc1',
    messagingSenderId: '877665265236',
    projectId: 'sic-home',
    authDomain: 'sic-home.firebaseapp.com',
    storageBucket: 'sic-home.appspot.com',
    measurementId: 'G-17MECG0DNX',
  );
}
