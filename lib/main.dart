import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_app/firebase_options.dart';
import 'package:threads_app/src/core/utils/environment.dart';
import 'package:threads_app/src/features/main/cubit/main_cubit.dart';
import 'package:threads_app/src/features/main/screens/main_screen.dart';
import 'package:threads_app/src/features/upload/cubit/upload_cubit.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // * native code (android/ios) start
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // * firebase -> flutter
  Environment.instance.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => MainCubit(),
      ),
      BlocProvider(
        create: (context) => UploadCubit(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}
