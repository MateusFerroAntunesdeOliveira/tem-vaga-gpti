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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAVprxEqzWbIjzp5TttaVGvwP1DBw0IY1E',
    appId: '1:500108947741:web:6835d7ac0c074f49e2b1f4',
    messagingSenderId: '500108947741',
    projectId: 'tem-vaga-b56e8',
    authDomain: 'tem-vaga-b56e8.firebaseapp.com',
    storageBucket: 'tem-vaga-b56e8.appspot.com',
    measurementId: 'G-2CSBSQR68B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2X-tl75TrWjCySBZiv1ltUNymzmO0xKs',
    appId: '1:500108947741:android:f606b6d0e584ade1e2b1f4',
    messagingSenderId: '500108947741',
    projectId: 'tem-vaga-b56e8',
    storageBucket: 'tem-vaga-b56e8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBC2_QHkOMNrZzcnEwdGEM3DfbAana2_JA',
    appId: '1:500108947741:ios:1a6cd609435b519fe2b1f4',
    messagingSenderId: '500108947741',
    projectId: 'tem-vaga-b56e8',
    storageBucket: 'tem-vaga-b56e8.appspot.com',
    iosClientId: '500108947741-sg2iftgku89bl7mn1blsklr6piv09khk.apps.googleusercontent.com',
    iosBundleId: 'com.example.temVaga',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBC2_QHkOMNrZzcnEwdGEM3DfbAana2_JA',
    appId: '1:500108947741:ios:1a6cd609435b519fe2b1f4',
    messagingSenderId: '500108947741',
    projectId: 'tem-vaga-b56e8',
    storageBucket: 'tem-vaga-b56e8.appspot.com',
    iosClientId: '500108947741-sg2iftgku89bl7mn1blsklr6piv09khk.apps.googleusercontent.com',
    iosBundleId: 'com.example.temVaga',
  );
}
