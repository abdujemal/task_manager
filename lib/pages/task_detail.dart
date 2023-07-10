import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/model/task_history_model.dart';
import 'package:task_manager/my_controller.dart';
import 'package:task_manager/pages/add_task.dart';
import 'package:task_manager/widgets/add_task_rank_history.dart';

import '../model/task_model.dart';
import '../widgets/add_task_history.dart';

class TaskDetail extends StatefulWidget {
  final int id;
  final String category;
  const TaskDetail({super.key, required this.id, required this.category});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  MyController myController = Get.find<MyController>();

  var eventController = EventController<TaskHistoryModel>();

  @override
  void initState() {
    getDatas();
    super.initState();
  }

  getDatas() async {
    await myController.getTaskHistories(
      widget.category == TaskCategory.akhira
          ? myController.akhiraTasks[widget.id].id! - 1
          : myController.dunyaTasks[widget.id].id! - 1,
    );
    setState(() {});
  }

  @override
  void dispose() {
    eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Detail"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => AddTask(
                  taskModel: widget.category == TaskCategory.akhira
                      ? myController.akhiraTasks[widget.id]
                      : myController.dunyaTasks[widget.id],
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Obx(() {
        TaskModel taskModel = widget.category == TaskCategory.akhira
            ? myController.akhiraTasks[widget.id]
            : myController.dunyaTasks[widget.id];

        if (myController.taskHistorystatus.value == RequestStatus.loaded) {
          eventController = EventController<TaskHistoryModel>();
          for (TaskHistoryModel model in myController.taskHistorys) {
            eventController.add(
              CalendarEventData(
                  startTime: DateTime.parse(model.date),
                  endTime:
                      DateTime.parse(model.date).add(const Duration(days: 1)),
                  endDate:
                      DateTime.parse(model.date).add(const Duration(days: 1)),
                  title: "${model.rank}",
                  date: DateTime.parse(model.date),
                  event: model),
            );
          }
        }

        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  taskModel.title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(taskModel.description),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text("Category:  "),
                        taskModel.category == TaskCategory.akhira
                            ? const Icon(
                                Icons.mosque,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.currency_bitcoin,
                                color: Colors.green,
                              ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Status:  "),
                        taskModel.status == TaskStatus.finished
                            ? const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.more_horiz,
                                color: Colors.orange,
                              ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: MonthView<TaskHistoryModel>(
                    controller: eventController,
                    headerStringBuilder: (date, {secondaryDate}) {
                      return "${DateFormat("MMMM").format(date)} / ${date.year}";
                    },
                    weekDayBuilder: (index) {
                      return Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            WeekDays.values[index].name
                                .substring(0, 1)
                                .capitalize!,
                          ),
                        ),
                      );
                    },
                    cellAspectRatio: 1,
                    cellBuilder: (date, events, isToday, isInMonth) {
                      // Return your widget to display full day event view.
                      Color? color = events.isNotEmpty
                          ? events[0].event!.rank <= 3
                              ? Colors.red
                              : events[0].event!.rank <= 6
                                  ? Colors.amber
                                  : Colors.green
                          : null;
                      return InkWell(
                        onTap: () {
                          if (myController.akhiraTasks[widget.id].description
                              .contains(',')) {
                            Get.bottomSheet(
                              AddTaskRankHistory(
                                dateTime: date,
                                taskId: taskModel.id! - 1,
                                taskModel: taskModel,
                                taskHistoryModel:
                                    events.isEmpty ? null : events[0].event,
                              ),
                            );
                          } else {
                            Get.bottomSheet(
                              AddTaskHistory(
                                dateTime: date,
                                taskId: widget.id,
                                taskHistoryModel:
                                    events.isEmpty ? null : events[0].event,
                              ),
                            );
                          }
                        },
                        child: Ink(
                          height: 61,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${date.day}"),
                                Text(
                                  events.isEmpty
                                      ? 'NG'
                                      : '${events[0].event!.rank}',
                                  style: TextStyle(color: color),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    headerStyle: HeaderStyle(
                      decoration: BoxDecoration(color: black),
                    ),
                    startDay: WeekDays.sunday,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
