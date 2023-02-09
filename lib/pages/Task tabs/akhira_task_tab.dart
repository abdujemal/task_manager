import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/my_controller.dart';
import 'package:task_manager/widgets/task_item.dart';

class AkhiraTaskTab extends StatefulWidget {
  const AkhiraTaskTab({super.key});

  @override
  State<AkhiraTaskTab> createState() => _AkhiraTaskTabState();
}

class _AkhiraTaskTabState extends State<AkhiraTaskTab> {
  MyController myController = Get.find<MyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: myController.akhiraTasks.length,
        itemBuilder: (context, index) => TaskItem(
          index: index,
          taskModel: myController.akhiraTasks[index],
        ),
      );
    });
  }
}
