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
    apiKey: 'AIzaSyAwFc0CuGYIwvoZIBOuLenY017HfmD4iRc',
    appId: '1:801594161690:web:3bdd0f1c380131323c6fa3',
    messagingSenderId: '801594161690',
    projectId: 'social-media-app-fd5bc',
    authDomain: 'social-media-app-fd5bc.firebaseapp.com',
    storageBucket: 'social-media-app-fd5bc.appspot.com',
    measurementId: 'G-Y8PJ35YVXY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6mjM-CPiZlOdPHw7OFnhmyH5nA6PR9Q8',
    appId: '1:801594161690:android:39dea16268fa8c843c6fa3',
    messagingSenderId: '801594161690',
    projectId: 'social-media-app-fd5bc',
    storageBucket: 'social-media-app-fd5bc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_Qgvyr7M3dQTzZPIdoVKRZ9vM5biONVU',
    appId: '1:801594161690:ios:2a889294a5fcfb033c6fa3',
    messagingSenderId: '801594161690',
    projectId: 'social-media-app-fd5bc',
    storageBucket: 'social-media-app-fd5bc.appspot.com',
    iosClientId: '801594161690-lo9bd6recbprc6q56s6r9b3d75217bu2.apps.googleusercontent.com',
    iosBundleId: 'com.example.instaClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_Qgvyr7M3dQTzZPIdoVKRZ9vM5biONVU',
    appId: '1:801594161690:ios:2a889294a5fcfb033c6fa3',
    messagingSenderId: '801594161690',
    projectId: 'social-media-app-fd5bc',
    storageBucket: 'social-media-app-fd5bc.appspot.com',
    iosClientId: '801594161690-lo9bd6recbprc6q56s6r9b3d75217bu2.apps.googleusercontent.com',
    iosBundleId: 'com.example.instaClone',
  );
}
