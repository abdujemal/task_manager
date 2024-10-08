import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/helper/database_helper.dart';
import 'package:task_manager/my_controller.dart';
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
      myController.getTasks().then((value) {
        myController.calcutaltePercentOfAll().then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainPage()),
              (_) => false);
        });
      });

      // sendNotification();
    });
  }

  // sendNotification() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   bool alreadySet = prefs.getBool("alreadySet") ?? false;
  //   if (!alreadySet) {
  //     NotificationService()
  //         .showNotification(0, "Anouncement", "Please evaluate your self.");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                "assets/logo.jpeg",
                height: 80,
                width: 80,
              ),
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
