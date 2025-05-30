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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBGy8VU4IO3Oa8KOnKxx4DkthcTTKL4640',
    appId: '1:352083475306:web:02d1d23eb294dbb49f8313',
    messagingSenderId: '352083475306',
    projectId: 'fir-b36f0',
    authDomain: 'fir-b36f0.firebaseapp.com',
    databaseURL: 'https://fir-b36f0-default-rtdb.firebaseio.com',
    storageBucket: 'fir-b36f0.firebasestorage.app',
    measurementId: 'G-FQS9FS5DQB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4_iacNetVRQLIQrFn-rpbM09S0etk3C4',
    appId: '1:352083475306:android:8ae74119c82f5e269f8313',
    messagingSenderId: '352083475306',
    projectId: 'fir-b36f0',
    databaseURL: 'https://fir-b36f0-default-rtdb.firebaseio.com',
    storageBucket: 'fir-b36f0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCH4sI3MVO6fCBDsRAuOVnOz0vHlBO82-c',
    appId: '1:352083475306:ios:067e3b7fff80f2699f8313',
    messagingSenderId: '352083475306',
    projectId: 'fir-b36f0',
    databaseURL: 'https://fir-b36f0-default-rtdb.firebaseio.com',
    storageBucket: 'fir-b36f0.firebasestorage.app',
    androidClientId: '352083475306-6taf7r7galpodtu2aj4llho7m27vhmat.apps.googleusercontent.com',
    iosClientId: '352083475306-qc23ulef4696hdgs7t20037ip7qg2b11.apps.googleusercontent.com',
    iosBundleId: 'com.app.pocketcoach',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBGy8VU4IO3Oa8KOnKxx4DkthcTTKL4640',
    appId: '1:352083475306:web:0639e095fb791f289f8313',
    messagingSenderId: '352083475306',
    projectId: 'fir-b36f0',
    authDomain: 'fir-b36f0.firebaseapp.com',
    databaseURL: 'https://fir-b36f0-default-rtdb.firebaseio.com',
    storageBucket: 'fir-b36f0.firebasestorage.app',
    measurementId: 'G-F3DSQ6T5XE',
  );

}