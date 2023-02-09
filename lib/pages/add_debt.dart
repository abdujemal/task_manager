import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/model/debt_model.dart';
import 'package:task_manager/my_controller.dart';
import 'package:task_manager/widgets/pick_date.dart';
import 'package:task_manager/widgets/sl_btn.dart';
import 'package:task_manager/widgets/sl_input.dart';

import '../widgets/my_dropdown.dart';

class AddDebt extends StatefulWidget {
  final DebtModel? debtModel;
  const AddDebt({super.key, this.debtModel});

  @override
  State<AddDebt> createState() => _AddDebtState();
}

class _AddDebtState extends State<AddDebt> {
  var formKey = GlobalKey<FormState>();
  MyController myController = Get.find<MyController>();

  var titleTc = TextEditingController();

  var descriptionTc = TextEditingController();

  var category = DebtCateogry.allah;

  var startDate = "";

  var endDate = "";

  var status = DebtStatus.notFullfilled;

  @override
  void initState() {
    startDate = DateTime.now().toString().split(" ")[0];
    endDate = DateTime.now().toString().split(" ")[0];

    if (widget.debtModel != null) {
      DebtModel debtModel = widget.debtModel!;
      titleTc.text = debtModel.title;
      descriptionTc.text = debtModel.description;
      category = debtModel.category;
      startDate = debtModel.takenDate;
      endDate = debtModel.dueDate;
      status = debtModel.status;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.debtModel != null ? "Edit Debt" : "Add Debt"),
        actions: [
          if (widget.debtModel != null)
            Obx(() {
              if (myController.status.value == RequestStatus.loading) {
                return const CircularProgressIndicator();
              }
              return IconButton(
                onPressed: () {
                  myController.deleteDebt(widget.debtModel!.id!);
                },
                icon: Icon(
                  Icons.delete,
                  color: ToastType.error,
                ),
              );
            })
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              SLInput(
                title: "Title",
                hint: "",
                keyboardType: TextInputType.text,
                controller: titleTc,
                isOutlined: true,
                inputColor: Colors.white,
                otherColor: Colors.grey,
              ),
              const SizedBox(
                height: 15,
              ),
              SLInput(
                title: "Descrition",
                hint: "",
                keyboardType: TextInputType.multiline,
                controller: descriptionTc,
                isOutlined: true,
                inputColor: Colors.white,
                otherColor: Colors.grey,
              ),
              const SizedBox(
                height: 15,
              ),
              MyDropdown(
                value: category,
                list: DebtCateogry.list,
                title: "Category",
                onChange: (val) {
                  setState(() {
                    category = val!;
                  });
                },
                width: double.infinity,
              ),
              const SizedBox(
                height: 15,
              ),
              PickDate(
                title: "Taken Date",
                currentDate: startDate,
                onChange: (val) {
                  setState(() {
                    startDate = val;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              PickDate(
                title: "Due Date",
                currentDate: endDate,
                onChange: (val) {
                  setState(() {
                    endDate = val;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              MyDropdown(
                value: status,
                list: DebtStatus.list,
                title: "Status",
                onChange: (val) {
                  setState(() {
                    status = val!;
                  });
                },
                width: double.infinity,
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(() {
                if (myController.status.value == RequestStatus.loading) {
                  return const CircularProgressIndicator();
                }
                return SLBtn(
                  text: widget.debtModel != null ? "Update" : "Save",
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (widget.debtModel == null) {
                        myController.addDebt(
                          DebtModel(
                            takenDate: startDate,
                            dueDate: endDate,
                            id: null,
                            title: titleTc.text,
                            description: descriptionTc.text,
                            status: status,
                            category: category,
                          ),
                        );
                      } else {
                        myController.updateDebt(
                          DebtModel(
                            takenDate: startDate,
                            dueDate: endDate,
                            id: widget.debtModel!.id,
                            title: titleTc.text,
                            description: descriptionTc.text,
                            status: status,
                            category: category,
                          ),
                        );
                      }
                    }
                  },
                );
              }),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
