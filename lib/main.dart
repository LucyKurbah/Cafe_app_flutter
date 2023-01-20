import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:cafe_app/home_card.dart';
import 'package:cafe_app/menu.dart';
import 'home_screen.dart';
import 'home.dart';
import 'coffee_card.dart';
import 'table_card.dart';
import 'menu.dart';
import 'cartscreen.dart';
import 'add_user.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', //id
  'High Importance Notifications', //title
  // 'This channel is used fro important notifications', //desc
  importance: Importance.high,
  playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Message : ${message.messageId}");
}


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  
  
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true
  // );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // int _counter =0;

  @override
  void initState(){
    super.initState();

    print('hello');
    // FirebaseMessaging.instance.getInitialMessage();

    //Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if(notification != null && android != null)
      {
        print(message.notification!.body);
        print(message.notification!.title);
        // flutterLocalNotificationsPlugin.show(notification.hashCode, 
        // notification.title, notification.body,
        // NotificationDetails(
        //   android: AndroidNotificationDetails(
        //     channel.id, channel.name,color: Colors.blue, playSound: true)
        // ));  
      }
      
    });
  }

  // void _incrementCounter(){
  //   setState(() {
  //     _counter++;
  //   });
  // }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafe App',
      // theme: ThemeData.dark(),
      
      home: const Home(),
      routes: {
          '/table': (context) => TableCard(),
          '/conference': (context) => CoffeeCard(),
          '/coffee': (context) => MenuPage(),
          '/floor': (context) => TableCard(),
          '/cart': (context) => CartScreen(),
          '/checkout': (context) => CartScreen(),
          '/profile': (context) => CartScreen(),
          '/login': (context) => CartScreen(),
          '/signup': (context) => CartScreen(),
      
      },
    );
  }
}
