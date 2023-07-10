import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/notification_service.dart';
import 'package:task_manager/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true),
      home: const SplashPage(),
    );
  }
}
