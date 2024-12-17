import 'package:authtask/core/routing/app_routher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'core/di/service_locator.dart';
import 'core/routing/routes.dart';
import 'feature/login/presentation/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA9-fx7wAgpRJL3q4witxzlDSN2zJKF-nI", // paste your api key here
      appId: "1:896087317228:android:3c45be3dea58ca5c59e3c9", //paste your app id here
      messagingSenderId: "896087317228", //paste your messagingSenderId here
      projectId: "onsale-7f4cb", //paste your project id here
    ),
  );
  await setupGetIt(); // Initialize dependencies


  runApp(MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
   MyApp({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
    initialRoute: Routes.loginScreen,
    onGenerateRoute: appRouter.generateRoute,);
  }
}
