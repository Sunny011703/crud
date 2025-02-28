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
    apiKey: 'AIzaSyA8Rdgh-6-aQdpnN_aKRQxe5dMRSYA18BE',
    appId: '1:302317663807:web:b0c918d94c2bb24769ea8a',
    messagingSenderId: '302317663807',
    projectId: 'employee-7745a',
    authDomain: 'employee-7745a.firebaseapp.com',
    storageBucket: 'employee-7745a.firebasestorage.app',
    measurementId: 'G-209DZHVQ6X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfGOmpRygsPnGv66IEWRmlo5eD47_C0lE',
    appId: '1:302317663807:android:178fe8cef77a842169ea8a',
    messagingSenderId: '302317663807',
    projectId: 'employee-7745a',
    storageBucket: 'employee-7745a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAknG0wDEUIGTpJa0zGBiWNJBixhWzIVlQ',
    appId: '1:302317663807:ios:b2c061f515a21b1b69ea8a',
    messagingSenderId: '302317663807',
    projectId: 'employee-7745a',
    storageBucket: 'employee-7745a.firebasestorage.app',
    iosClientId: '302317663807-uvgh9hgk3av96ejond501iefu4cq2b40.apps.googleusercontent.com',
    iosBundleId: 'com.example.appcurd',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAknG0wDEUIGTpJa0zGBiWNJBixhWzIVlQ',
    appId: '1:302317663807:ios:b2c061f515a21b1b69ea8a',
    messagingSenderId: '302317663807',
    projectId: 'employee-7745a',
    storageBucket: 'employee-7745a.firebasestorage.app',
    iosClientId: '302317663807-uvgh9hgk3av96ejond501iefu4cq2b40.apps.googleusercontent.com',
    iosBundleId: 'com.example.appcurd',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA8Rdgh-6-aQdpnN_aKRQxe5dMRSYA18BE',
    appId: '1:302317663807:web:35786f61ee82028269ea8a',
    messagingSenderId: '302317663807',
    projectId: 'employee-7745a',
    authDomain: 'employee-7745a.firebaseapp.com',
    storageBucket: 'employee-7745a.firebasestorage.app',
    measurementId: 'G-TLFZVSD51T',
  );
}
