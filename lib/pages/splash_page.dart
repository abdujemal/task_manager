import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/helper/database_helper.dart';
import 'package:task_manager/my_controller.dart';
import 'package:task_manager/notification_service.dart';
import 'package:task_manager/pages/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  MyController myController = Get.put(MyController());

  @override
  void initState() {
    super.initState();
    DatabaseHelper().database.then((value) {
      myController.getDebt();
      myController.getTasks();

      sendNotification();
    });

    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const MainPage()), (_) => false);
    });
  }

  sendNotification() async {
    final prefs = await SharedPreferences.getInstance();
    bool alreadySet = prefs.getBool("alreadySet") ?? false;
    if (!alreadySet) {
      NotificationService()
          .showNotification(0, "Anouncement", "Please evaluate your self.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.task_sharp,
              color: primaryColor,
              size: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            logo(),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
