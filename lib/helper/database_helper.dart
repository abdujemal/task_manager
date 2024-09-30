import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/model/debt_model.dart';
import 'package:task_manager/model/task_history_model.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/notification_service.dart';

import '../constants.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}taskManager.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    if (kDebugMode) {
      print("db is ready");
    }
    return notesDatabase;
  }

  Future<Database?> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  //creating database
  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${DatabaseConst.task}('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title TEXT,'
        'description TEXT,'
        'scheduleTime TEXT,'
        'status TEXT,'
        'category TEXT,'
        'startDate TEXT,'
        'endDate TEXT'
        ')');

    await db.execute('CREATE TABLE ${DatabaseConst.taskHistory}('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'taskId INTEGER,'
        'date TEXT,'
        'rank INTEGER,'
        'individualRanks TEXT'
        ')');

    await db.execute('CREATE TABLE ${DatabaseConst.debt}('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title TEXT,'
        'description TEXT,'
        'status TEXT,'
        'cateogry TEXT,'
        'takenDate TEXT,'
        'dueDate TEXTb'
        ')');
  }

  //geting data
  Future<List<TaskModel>> getTaskList() async {
    Database? db = await database;

    var result = await db!.query(DatabaseConst.task, orderBy: 'id ASC');
    List<TaskModel> tasks = [];
    for (var taskDb in result) {
      tasks.add(TaskModel.fromMap(taskDb));
    }
    return tasks;
  }

  Future<List<TaskHistoryModel>> getTaskHistoryList(int taskId) async {
    Database? db = await database;

    var result = await db!.query(DatabaseConst.taskHistory,
        orderBy: 'id ASC', where: 'taskId = ?', whereArgs: [taskId]);
    List<TaskHistoryModel> histories = [];
    for (var historyDb in result) {
      histories.add(TaskHistoryModel.fromMap(historyDb));
    }
    return histories;
  }

  Future<double> getPanishment() async {
    Database? db = await database;

    var result = await db!.query(
      DatabaseConst.taskHistory,
      columns: ['rank'],
    );

    double sumOfHistories = 0;
    for (var taskHistory in result) {
      // TaskHistoryModel model = TaskHistoryModel.fromMap(taskHistory);
      sumOfHistories += taskHistory['rank'] as int;
      print(taskHistory['rank']);
    }
    return (result.length * 10) - sumOfHistories;
  }

  Future<List<DebtModel>> getDebtList() async {
    Database? db = await database;

    var result = await db!.query(DatabaseConst.debt, orderBy: 'id ASC');
    List<DebtModel> debtes = [];
    for (var debtDb in result) {
      debtes.add(DebtModel.fromMap(debtDb));
    }
    return debtes;
  }

  //inserting data
  Future<int> insertTask(TaskModel taskModel, DateTime dateTime) async {
    Database? db = await database;
    var result = await db!.insert(DatabaseConst.task, taskModel.toMap());
    // AndroidAlarmManager.periodic(const Duration(days: 1), result, ring,
    //     startAt: dateTime);
    NotificationService().showNotification(
        result, taskModel.title, "Check it right now or your done!", dateTime);
    return result;
  }

  Future<int> insertTaskHistory(TaskHistoryModel taskHistoryModel) async {
    print(taskHistoryModel.toMap());
    Database? db = await database;
    var result =
        await db!.insert(DatabaseConst.taskHistory, taskHistoryModel.toMap());
    return result;
  }

  Future<int> insertDebt(DebtModel debtModel) async {
    Database? db = await database;
    var result = await db!.insert(DatabaseConst.debt, debtModel.toMap());
    return result;
  }

  //update data
  Future<int> updateTask(TaskModel taskModel, DateTime dateTime) async {
    var db = await database;
    var result = await db!.update(DatabaseConst.task, taskModel.toMap(),
        where: 'id = ?', whereArgs: [taskModel.id]);
    // AndroidAlarmManager.periodic(const Duration(days: 1), result, ring,
    //     startAt: dateTime);
    NotificationService().cancelNotification(taskModel.id!);
    NotificationService().showNotification(taskModel.id!, taskModel.title,
        "Check it right now or your done!", dateTime);
    return result;
  }

  Future<int> updateTaskHistory(TaskHistoryModel taskHistoryModel) async {
    var db = await database;
    var result = await db!.update(
        DatabaseConst.taskHistory, taskHistoryModel.toMap(),
        where: 'id = ?', whereArgs: [taskHistoryModel.id]);
    return result;
  }

  Future<int> updateDebt(DebtModel debtModel) async {
    var db = await database;
    var result = await db!.update(DatabaseConst.debt, debtModel.toMap(),
        where: 'id = ?', whereArgs: [debtModel.id]);
    return result;
  }

  //deleta data
  Future<int> deleteTask(int id) async {
    var db = await database;
    var result =
        await db!.rawDelete('DELETE FROM ${DatabaseConst.task} WHERE id = $id');
    // AndroidAlarmManager.cancel(id);
    NotificationService().cancelNotification(id);
    return result;
  }

  Future<int> deleteTaskHistory({int? id, int? taskId}) async {
    var db = await database;
    var result = id == null
        ? await db!.rawDelete(
            'DELETE FROM ${DatabaseConst.taskHistory} WHERE taskId = $taskId')
        : await db!.rawDelete(
            'DELETE FROM ${DatabaseConst.taskHistory} WHERE id = $id');
    return result;
  }

  Future<int> deleteDebt(int id) async {
    var db = await database;
    var result =
        await db!.rawDelete('DELETE FROM ${DatabaseConst.debt} WHERE id = $id');
    return result;
  }

  //get number of datas present in the daata base
  // Future<int> getCount() async {
  //   Database db = await this.database;
  //   List<Map<String, dynamic>> x =
  //       await db.rawQuery('SELECT COUNT (*) from $noteTable');
  //   int result = Sqflite.firstIntValue(x);
  //   return result;
  // }
}

ring() {
  NotificationService().showNotification(
      1, "Check your task", "do it right now.", DateTime.now());
}
