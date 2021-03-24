import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/blueprints/cloud_firebase_messaging.dart';
import 'core/routes.dart';
import 'core/utils/shared_prefs.dart';

final prefs = MyShPrefs();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await prefs.initPrefs();
  cloudMessaging.setMessageHandler();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final initialRoute = prefs.name.isEmpty ? Routes.login : Routes.dashboard;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Angora Demo',
      initialRoute: initialRoute,
      getPages: Routes.pages,
    );
  }
}
