import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../my_controller.dart';
import '../../widgets/task_item.dart';

class DunyaTaskTab extends StatefulWidget {
  const DunyaTaskTab({super.key});

  @override
  State<DunyaTaskTab> createState() => _DunyaTaskTabState();
}

class _DunyaTaskTabState extends State<DunyaTaskTab> {
  MyController myController = Get.find<MyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: myController.dunyaTasks.length,
        itemBuilder: (context, index) => TaskItem(
          index: index,
          taskModel: myController.dunyaTasks[index],
        ),
      );
    });
  }
}