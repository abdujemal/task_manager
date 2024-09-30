import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/notification_service.dart';
import 'package:task_manager/pages/splash_page.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await AndroidAlarmManager.initialize()
  //     .then(
  //       (value) => toast(value ? "Alarm service started" : "pshyc! that is not working", ToastType.success),
  //     )
  //     .catchError(
  //       (e) => toast(e.toString(), ToastType.error),
  //     );
  await NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      // localizationsDelegates: [
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      supportedLocales: const [Locale('en', 'US')],
      theme: ThemeData.dark(useMaterial3: true),
      home: const SplashPage(),
    );
  }
}