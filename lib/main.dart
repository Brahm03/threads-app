import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:threads_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // * native code (android/ios) start
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // * firebase -> flutter
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
