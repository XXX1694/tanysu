// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
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
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5aFQqEo3LdVYeVOvi6a7s9XCjMS28QxU',
    appId: '1:848296565441:android:1305e6b53cf60e086ad240',
    messagingSenderId: '848296565441',
    projectId: 'tanysu-a540c',
    storageBucket: 'tanysu-a540c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBp8VNewCILJgEIdEKdA7KEaSYuT2iLqM0',
    appId: '1:848296565441:ios:65dddaeec8d0ba536ad240',
    messagingSenderId: '848296565441',
    projectId: 'tanysu-a540c',
    storageBucket: 'tanysu-a540c.appspot.com',
    androidClientId: '848296565441-71k2ui01gvuhsfja4uvm2r2ds4vor975.apps.googleusercontent.com',
    iosClientId: '848296565441-1elfje98klslc3rh5pns80rmo4ghm194.apps.googleusercontent.com',
    iosBundleId: 'com.tanysu.kz',
  );
}
