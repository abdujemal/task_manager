import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/constants.dart';
import 'package:task_manager/helper/database_helper.dart';
import 'package:task_manager/model/debt_model.dart';
import 'package:task_manager/model/task_history_model.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/pages/add_debt.dart';

class MyController extends GetxController {
  RxList<TaskModel> dunyaTasks = <TaskModel>[].obs;
  RxList<TaskModel> akhiraTasks = <TaskModel>[].obs;
  RxList<TaskHistoryModel> taskHistorys = <TaskHistoryModel>[].obs;
  RxList<DebtModel> allahsdebts = <DebtModel>[].obs;
  RxList<DebtModel> peoplesdebts = <DebtModel>[].obs;

  Rx<RequestStatus> status = RequestStatus.idle.obs;
  Rx<RequestStatus> taskHistorystatus = RequestStatus.idle.obs;

  RxInt currentIndex = 0.obs;

  setCurrentTabIndex(int val) {
    currentIndex.value = val;
    update();
  }

  getTasks() async {
    status.value = RequestStatus.loading;
    try {
      final res = await DatabaseHelper().getTaskList();
      dunyaTasks.value = res
          .where((element) => element.category == TaskCategory.dunya)
          .toList();
      akhiraTasks.value = res
          .where((element) => element.category == TaskCategory.akhira)
          .toList();

      dunyaTasks.sort((a, b) => b.status.compareTo(a.status));
      akhiraTasks.sort((a, b) => b.status.compareTo(a.status));

      status.value = RequestStatus.loaded;
    } catch (e) {
      toast(e.toString(), ToastType.error);
      status.value = RequestStatus.error;
    }
  }

  // get

  getDebt() async {
    status.value = RequestStatus.loading;
    try {
      final res = await DatabaseHelper().getDebtList();
      allahsdebts.value = res
          .where((element) => element.category == DebtCateogry.allah)
          .toList();
      peoplesdebts.value = res
          .where((element) => element.category == DebtCateogry.people)
          .toList();

      allahsdebts.sort((a, b) => b.status.compareTo(a.status));
      peoplesdebts.sort((a, b) => b.status.compareTo(a.status));
      status.value = RequestStatus.loaded;
    } catch (e) {
      toast(e.toString(), ToastType.error);
      status.value = RequestStatus.error;
    }
  }

  getTaskHistories(int id) async {
    taskHistorystatus.value = RequestStatus.loading;
    try {
      taskHistorys.value = [];
      final res = await DatabaseHelper().getTaskHistoryList(id);
      taskHistorys.value = res;
      print('taskHM id: $id');
      print("taskHM History: ${taskHistorys.value}");
      taskHistorystatus.value = RequestStatus.loaded;
    } catch (e) {
      toast(e.toString(), ToastType.error);
      taskHistorystatus.value = RequestStatus.error;
    }
  }
  
  // add
    
  addTask(TaskModel taskModel) async {
    status.value = RequestStatus.loading;
    try {
      await DatabaseHelper().insertTask(taskModel);
      await getTasks();
      Get.back();
      status.value = RequestStatus.loaded;
    } catch (e) {
      toast(e.toString(), ToastType.error);
      status.value = RequestStatus.error;
    }
  }

  addDebt(DebtModel debtModel) async {
    status.value = RequestStatus.loading;
    try {
      await DatabaseHelper().insertDebt(debtModel);
      await getDebt();
      Get.back();
      status.value = RequestStatus.loaded;
    } catch (e) {
      toast(e.toString(), ToastType.error);
      status.value = RequestStatus.error;
    }
  }

  addTaskHistory(TaskHistoryModel taskHistoryModel) async {
    status.value = RequestStatus.loading;
    try {
      await DatabaseHelper().insertTaskHistory(taskHistoryModel);
      await getTaskHistories(taskHistoryModel.taskId);
      status.value = RequestStatus.loaded;
      Get.back();
    } catch (e) {
      toast(e.toString(), ToastType.error);
      status.value = RequestStatus.error;
    }
  }

// update
  updateTaskHistory(TaskHistoryModel taskHistoryModel) async {
    status.value = RequestStatus.loading;
    try {
      await DatabaseHelper().updateTaskHistory(taskHistoryModel);
      await getTaskHistories(taskHistoryModel.taskId);
      status.value = RequestStatus.loaded;
      Get.back();
    } catch (e) {
      toast(e.toString(), ToastType.error);
      status.value = RequestStatus.error;
    }
  }

  updateTask(TaskModel taskModel) async {
    status.value = RequestStatus.loading;
    try {
      await DatabaseHelper().updateTask(taskModel);
      await getTasks();
      Get.back();
      status.value = RequestStatus.loaded;
    } catch (e) {
      toast(e.toString(), ToastType.error);
      status.value = RequestStatus.error;
    }
  }

  updateDebt(DebtModel debtModel) async {
    status.value = RequestStatus.loading;
    try {
      await DatabaseHelper().updateDebt(debtModel);
      await getDebt();
      Get.back();
      status.value = RequestStatus.loaded;
    } catch (e) {
      toast(e.toString(), ToastType.error);
      status.value = RequestStatus.error;
    }
  }

  // delete

  deleteTask(int id) async {
    status.value = RequestStatus.loading;
    try {
      await DatabaseHelper().deleteTask(id);
      await DatabaseHelper().deleteTaskHistory(taskId: id);
      await getTasks();
      await getTaskHistories(id);
      status.value = RequestStatus.loaded;
      Get.back();
    } catch (e) {
      toast(e.toString(), ToastType.error);
      status.value = RequestStatus.error;
    }
  }

  deleteDebt(int id) async {
    status.value = RequestStatus.loading;
    try {
      await DatabaseHelper().deleteDebt(id);
      await getDebt();
      status.value = RequestStatus.loaded;
      Get.back();
    } catch (e) {
      toast(e.toString(), ToastType.error);
      status.value = RequestStatus.error;
    }
  }
}
