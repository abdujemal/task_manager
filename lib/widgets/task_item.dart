import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/pages/task_detail.dart';

import '../constants.dart';

class TaskItem extends StatelessWidget {
  final int index;
  final TaskModel taskModel;
  const TaskItem({super.key, required this.taskModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(
          () => TaskDetail(
            id: index,
            category: taskModel.category,
          ),
        );
      },
      leading: const Icon(Icons.task_alt),
      title: Text(taskModel.title),
      subtitle: Text(
        taskModel.description,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: taskModel.status == TaskStatus.finished
            ? const Icon(
                Icons.check,
                color: Colors.green,
              )
            : Icon(
                Icons.more_horiz,
                color: primaryColor,
              ),
      ),
    );
  }
}
