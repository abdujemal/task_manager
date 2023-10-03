import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/my_controller.dart';

class BottomNavItem extends StatelessWidget {
  String label;
  IconData iconData;
  int index;
  void Function() onTap;

  BottomNavItem({
    Key? key,
    required this.label,
    required this.iconData,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  MyController myController = Get.find<MyController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        height: 70,
        width: 60,
        child: Obx(
          () => SizedBox(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: myController.currentIndex.value == index
                      ? Colors.white
                      : Colors.white30,
                  size: 35,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: myController.currentIndex.value == index
                        ? Colors.white
                        : Colors.white30,
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
