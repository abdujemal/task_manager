import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/model/task_history_model.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/my_controller.dart';
import 'package:task_manager/widgets/sl_btn.dart';
import 'package:task_manager/widgets/sl_input.dart';

class AddTaskHistory extends StatefulWidget {
  final DateTime dateTime;
  final TaskHistoryModel? taskHistoryModel;
  final int taskId;
  const AddTaskHistory(
      {super.key,
      required this.taskId,
      this.taskHistoryModel,
      required this.dateTime});

  @override
  State<AddTaskHistory> createState() => _AddTaskHistoryState();
}

class _AddTaskHistoryState extends State<AddTaskHistory> {
  TextEditingController rankTc = TextEditingController();
  MyController myController = Get.find<MyController>();

  @override
  void initState() {
    if (widget.taskHistoryModel != null) {
      rankTc.text = widget.taskHistoryModel!.rank.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
          color: black,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Task Rank",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 25,
          ),
          SLInput(
            isOutlined: true,
            title: "Rank",
            hint: "1 - 10",
            inputColor: Colors.white,
            otherColor: Colors.grey,
            keyboardType: TextInputType.number,
            controller: rankTc,
          ),
          const SizedBox(
            height: 20,
          ),
          Builder(builder: (context) {
            if (myController.status.value == RequestStatus.loading) {
              return const CircularProgressIndicator();
            }
            return SLBtn(
              text: widget.taskHistoryModel != null ? "Update" : "Add",
              onTap: () {
                if (rankTc.text.isEmpty) {
                  toast("Rank is empty.", ToastType.warning);
                } else {
                  if (widget.taskHistoryModel == null) {
                    print(TaskHistoryModel(
                        id: widget.dateTime.millisecondsSinceEpoch,
                        taskId: widget.taskId,
                        date: widget.dateTime.toString().split(" ")[0],
                        rank: int.parse(
                          rankTc.text,
                        )).toMap());
                    myController.addTaskHistory(
                      TaskHistoryModel(
                        id: widget.dateTime.millisecondsSinceEpoch,
                        taskId: widget.taskId,
                        date: widget.dateTime.toString().split(" ")[0],
                        rank: int.parse(
                          rankTc.text,
                        ),
                      ),
                    );
                  } else {
                    myController.updateTaskHistory(
                      TaskHistoryModel(
                        id: widget.taskHistoryModel!.id,
                        taskId: widget.taskId,
                        date: widget.dateTime.toString().split(" ")[0],
                        rank: int.parse(
                          rankTc.text,
                        ),
                      ),
                    );
                  }
                }
              },
            );
          })
        ],
      ),
    );
  }
}
