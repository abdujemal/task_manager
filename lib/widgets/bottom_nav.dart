import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/my_controller.dart';
import 'package:task_manager/widgets/bottom_nav_item.dart';

import '../constants.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  
  MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
      child: BottomAppBar(
        height: 95,
        shape: const CircularNotchedRectangle(),
        notchMargin: 15,
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavItem(
                onTap: () {
                  myController.setCurrentTabIndex(0);
                },
                label: "Tasks",
                iconData: Icons.task,
                index: 0,
              ),
              const SizedBox(
                width: 40,
              ),              
              BottomNavItem(
                onTap: () {
                  myController.setCurrentTabIndex(1);
                },
                label: "Debts",
                iconData: Icons.payment,
                index: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
