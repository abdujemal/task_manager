import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/my_controller.dart';
import 'package:task_manager/widgets/my_dropdown.dart';
import 'package:task_manager/widgets/sl_input.dart';

import '../widgets/pick_date.dart';
import '../widgets/sl_btn.dart';

class AddTask extends StatefulWidget {
  final TaskModel? taskModel;
  const AddTask({super.key, this.taskModel});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  MyController myController = Get.find<MyController>();

  var category = TaskCategory.akhira;

  var endDate = "";

  var startDate = "";

  var status = TaskStatus.notFinished;

  var titleTc = TextEditingController();

  var descriptionTc = TextEditingController();

  var formKey = GlobalKey<FormState>();

  String notificationTime = "";

  final _timeController = TextEditingController();

  DateTime selectedSheduleDateTime = DateTime.now();

  Future<void> _showTimePicker(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _timeController.text.isEmpty
          ? TimeOfDay.now()
          : TimeOfDay.fromDateTime(
              selectedSheduleDateTime,
            ),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      final DateTime currentTime = DateTime.now();
      selectedSheduleDateTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      _timeController.text = DateFormat.jm().format(selectedSheduleDateTime);
    }
  }

  @override
  void initState() {
    startDate = DateTime.now().toString().split(" ")[0];
    endDate = DateTime.now().toString().split(" ")[0];
    notificationTime = DateTime.now().toString().split(" ")[1];

    if (widget.taskModel != null) {
      TaskModel taskModel = widget.taskModel!;
      category = taskModel.category;
      endDate = taskModel.endDate;
      startDate = taskModel.startDate;
      status = taskModel.status;
      titleTc.text = taskModel.title;
      descriptionTc.text = taskModel.description;
      _timeController.text = DateFormat.jm().format(
        DateTime.parse(taskModel.scheduleTime),
      );
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskModel != null ? "Edit Task" : "Add Task"),
        centerTitle: true,
        actions: [
          if (widget.taskModel != null)
            Obx(() {
              if (myController.status.value == RequestStatus.loading) {
                return const CircularProgressIndicator();
              }
              return IconButton(
                onPressed: () {
                  myController.deleteTask(widget.taskModel!.id!);
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  list: TaskCategory.list,
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
                SLInput(
                  title: "Notification Schedule",
                  hint: "",
                  keyboardType: TextInputType.text,
                  controller: _timeController,
                  isOutlined: true,
                  inputColor: Colors.white,
                  otherColor: Colors.grey,
                  readOnly: true,
                  onTap: () {
                    _showTimePicker(context);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                PickDate(
                  title: "Start Date",
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
                  title: "End Date",
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
                  list: TaskStatus.list,
                  title: "Status",
                  onChange: (val) {
                    setState(() {
                      status = val!;
                    });
                  },
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(() {
                  if (myController.status.value == RequestStatus.loading) {
                    return const CircularProgressIndicator();
                  }
                  return SLBtn(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (widget.taskModel != null) {
                          myController.updateTask(
                            TaskModel(
                              id: widget.taskModel!.id!,
                              title: titleTc.text,
                              description: descriptionTc.text,
                              status: status,
                              category: category,
                              startDate: startDate,
                              endDate: endDate,
                              scheduleTime: selectedSheduleDateTime.toString(),
                            ),
                            selectedSheduleDateTime,
                          );
                        } else {
                          myController.addTask(
                            TaskModel(
                                id: null,
                                title: titleTc.text,
                                description: descriptionTc.text,
                                status: status,
                                category: category,
                                startDate: startDate,
                                endDate: endDate,
                                scheduleTime:
                                    selectedSheduleDateTime.toString()),
                            selectedSheduleDateTime,
                          );
                        }
                      }
                    },
                    text: widget.taskModel != null ? "Update" : "Save",
                  );
                }),
                const SizedBox(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
