import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../my_controller.dart';
import '../../widgets/debt_item.dart';

class PeoplesDebt extends StatefulWidget {
  const PeoplesDebt({super.key});

  @override
  State<PeoplesDebt> createState() => _PeoplesDebtState();
}

class _PeoplesDebtState extends State<PeoplesDebt> {
   MyController myController = Get.find<MyController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: myController.peoplesdebts.length,
        itemBuilder: (context, index) => DebtItem(
          debtModel: myController.peoplesdebts[index],
        ),
      );
    });
  }
}
