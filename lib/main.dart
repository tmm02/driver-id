import 'package:action_broadcast/action_broadcast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/splash.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //FirebaseMessaging.instance.getToken().then((fcmId) => print(fcmId));
  FirebaseMessaging.instance.subscribeToTopic("messaging");

  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("message recieved");
    sendBroadcast('transaksi', extras:event.data);
    print(event.data);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('Message clicked!');
  });

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));

  //HttpOverrides.global = MyHttpOverrides();
  runApp(App());
}


class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      //theme: ThemeData(fontFamily: 'DM_Sans'),
      home: Scaffold(
        body: Splash(),
      ),
    );



  }
}

