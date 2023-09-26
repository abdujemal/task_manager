
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/widgets/sl_btn.dart';

import '../constants.dart';
import '../model/task_history_model.dart';
import '../my_controller.dart';

class AddTaskRankHistory extends StatefulWidget {
  final DateTime dateTime;
  final TaskHistoryModel? taskHistoryModel;
  final TaskModel taskModel;
  final int taskId;
  const AddTaskRankHistory({
    super.key,
    required this.taskModel,
    required this.dateTime,
    this.taskHistoryModel,
    required this.taskId,
  });

  @override
  State<AddTaskRankHistory> createState() => _AddTaskRankHistoryState();
}

class _AddTaskRankHistoryState extends State<AddTaskRankHistory> {
  List<String> subTasks = [];
  List<bool> ranks = [];
  MyController myController = Get.find<MyController>();

  @override
  void initState() {
    super.initState();

    subTasks = widget.taskModel.description.split(",").toList();

    if (widget.taskHistoryModel != null) {
      ranks = widget.taskHistoryModel!.individualRanks
          .split(',')
          .map((e) => e == "true")
          .toList();
    } else {
      ranks = List.generate(subTasks.length, (index) => false);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
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
            ...List.generate(
              subTasks.length,
              (index) => CheckboxListTile(
                value: ranks[index],
                title: Text(subTasks[index]),
                checkColor: Colors.green,
                activeColor: Colors.white,
                onChanged: (b) {
                  setState(
                    () {
                      ranks[index] = b!;
                    },
                  );
                },
              ),
            ),
            Builder(builder: (context) {
              if (myController.status.value == RequestStatus.loading) {
                return const CircularProgressIndicator();
              }
              return SLBtn(
                text: widget.taskHistoryModel != null ? "Update" : "Add",
                onTap: () {
                  String individualRanks = "";
                  int i = 0;
                  int rank = 0;
                  for (bool r in ranks) {
                    individualRanks += '$r';
                    if (ranks.length - 1 != i) {
                      individualRanks += ',';
                    }
                    if (r == true) {
                      rank++;
                    }
                    i++;
                  }
                  print(individualRanks);
                  if (widget.taskHistoryModel == null) {
                    print(TaskHistoryModel(
                            // id: widget.dateTime.millisecondsSinceEpoch,
                            id: null,
                            individualRanks: individualRanks,
                            taskId: widget.taskId,
                            date: widget.dateTime.toString().split(" ")[0],
                            rank: rank)
                        .toMap());
                    myController.addTaskHistory(
                      TaskHistoryModel(
                        // id: widget.dateTime.millisecondsSinceEpoch,
                        id: null,
                        individualRanks: individualRanks,
                        taskId: widget.taskId,
                        date: widget.dateTime.toString().split(" ")[0],
                        rank: ((rank / subTasks.length) * 10).round(),
                      ),
                    );
                  } else {
                    myController.updateTaskHistory(
                      TaskHistoryModel(
                        id: widget.taskHistoryModel!.id,
                        individualRanks: individualRanks,
                        taskId: widget.taskId,
                        date: widget.dateTime.toString().split(" ")[0],
                        rank: ((rank / subTasks.length) * 10).round(),
                      ),
                    );
                  }
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
