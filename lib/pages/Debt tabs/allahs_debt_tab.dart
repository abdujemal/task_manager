import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:task_manager/widgets/debt_item.dart';

import '../../my_controller.dart';

class AllahsDebt extends StatefulWidget {
  const AllahsDebt({super.key});

  @override
  State<AllahsDebt> createState() => _AllahsDebtState();
}

class _AllahsDebtState extends State<AllahsDebt> {
  MyController myController = Get.find<MyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: myController.allahsdebts.length,
        itemBuilder: (context, index) => DebtItem(
          debtModel: myController.allahsdebts[index],
        ),
      );
    });
  }
}