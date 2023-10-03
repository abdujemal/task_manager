import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/model/debt_model.dart';
import 'package:task_manager/pages/add_debt.dart';

class DebtItem extends StatelessWidget {
  final DebtModel debtModel;
  const DebtItem({super.key, required this.debtModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(
          () => AddDebt(
            debtModel: debtModel,
          ),
        );
      },
      title: Text(debtModel.title),
      subtitle: Text(
        debtModel.description,
        overflow: TextOverflow.ellipsis,
      ),
      leading: const Icon(Icons.featured_play_list_rounded),
      trailing: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: debtModel.status == DebtStatus.fullfilled
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
