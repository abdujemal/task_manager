import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/my_controller.dart';
import 'package:task_manager/pages/debt_page.dart';
import 'package:task_manager/pages/task_page.dart';
import 'package:task_manager/widgets/add_dialogue.dart';

import '../widgets/bottom_nav.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MyController myController = Get.find<MyController>();

  bool showDialogue = false;

  List<Widget> pages = [const TaskPage(), const DebtPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_sharp,
              color: primaryColor,
              size: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            logo(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: primaryColor,
        child: Icon(showDialogue ? Icons.close : Icons.add, size: 40,),
        onPressed: () {
          setState(() {
            showDialogue = !showDialogue;
          });
        },
      ),
      bottomNavigationBar: const BottomNav(),
      body: Stack(
        children: [
          Obx(() => pages[myController.currentIndex.value]),
          AnimatedPositioned(
            bottom: showDialogue ? 50 : -160 ,
            left:( MediaQuery.of(context).size.width/2)-115,
            curve: Curves.bounceOut,
            duration: const Duration(seconds: 2),
            child: const AddDialogue(), 
          )
        ],
      ),
    );
  }
}
