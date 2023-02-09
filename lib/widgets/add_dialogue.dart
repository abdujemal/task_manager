import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/pages/add_debt.dart';

import '../constants.dart';
import '../pages/add_task.dart';

class AddDialogue extends StatefulWidget {
  const AddDialogue({super.key});

  @override
  State<AddDialogue> createState() => _AddDialogueState();
}

class _AddDialogueState extends State<AddDialogue> {
  List<AddMenu> items = [
    AddMenu(Icons.task, "Task", const AddTask()),
    AddMenu(Icons.payment_outlined, "Debt", const AddDebt()),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(192, 0, 0, 0),
                spreadRadius: 2,
                blurRadius: 15)
          ]),
      width: 230,
      height: 150,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: List.generate(
            items.length,
            (index) => ListTile(
                  onTap: () {
                    Get.to(() => items[index].page);
                  },
                  leading: Icon(
                    items[index].icon,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    items[index].name,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                )),
      ),
    );
  }
}

class AddMenu {
  String name;
  IconData icon;
  Widget page;
  AddMenu(this.icon, this.name, this.page);
}
