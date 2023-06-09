// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// / Default [FirebaseOptions] for use with your Firebase apps.
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDycHi7ivcmumm3_wkRjYDScADFwK7YipU',
    appId: '1:1030651474881:android:de6fbe8408433fff9d7540',
    messagingSenderId: '1030651474881',
    projectId: 'azure-rays-mobile',
    authDomain: 'champ-play.firebaseapp.com',
    storageBucket: 'champ-play.appspot.com',
    measurementId: 'G-2BX6WTVKF8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDycHi7ivcmumm3_wkRjYDScADFwK7YipU',
    appId: '1:1030651474881:android:de6fbe8408433fff9d7540',
    messagingSenderId: '1030651474881',
    projectId: 'champ-play',
    storageBucket: 'champ-play.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDycHi7ivcmumm3_wkRjYDScADFwK7YipU',
    appId: '1:1030651474881:android:de6fbe8408433fff9d7540',
    messagingSenderId: '1030651474881',
    projectId: 'champ-play',
    storageBucket: 'champ-play.appspot.com',
    iosClientId:
        '763134542523-ob8rv997r21phv4vudkb98b4l3qg195n.apps.googleusercontent.com',
    iosBundleId: 'azure-rays-mobile',
  );
}
