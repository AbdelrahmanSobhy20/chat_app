import 'package:chat_app/presentation/manager/background_color_provider.dart';
import 'package:chat_app/presentation/manager/chat_box_color_provider.dart';
import 'package:chat_app/presentation/manager/chat_message_provider.dart';
import 'package:chat_app/presentation/views/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (context) => ChatBoxColorProvider(),),
        ChangeNotifierProvider(create: (context) => BackgroundColorProvider(),),
        ChangeNotifierProvider(create: (context) => ChatMessageProvider(),),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

