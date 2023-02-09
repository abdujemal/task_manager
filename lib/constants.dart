import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Colors.amber;

Color black = Color.fromARGB(
  255,
  36,
  36,
  36,
);

logo() {
  return Text(
    "Task Manager",
    style: GoogleFonts.akronim().copyWith(fontSize: 25, color: Colors.white),
  );
}

class DatabaseConst {
  static String task = "task";
  static String taskHistory = "taskHistory";
  static String debt = 'debt';
}

class TaskStatus {
  static String notFinished = "not finished";
  static String finished = "finished";
  static List<String> list = [finished, notFinished];
}

class TaskCategory {
  static String dunya = 'Dunya';
  static String akhira = "Akhira";
  static List<String> list = [dunya, akhira];
}

class DebtCateogry {
  static String allah = "Allah's";
  static String people = "People's";
  static List<String> list = [allah, people];
}

class DebtStatus {
  static String fullfilled = "Fullfilled";
  static String notFullfilled = "Not Fullfilled";
  static List<String> list = [fullfilled, notFullfilled];
}

enum RequestStatus {
  idle,
  loading,
  error,
  loaded,
}

class ToastType {
  static Color warning = Colors.amber.shade400;
  static Color error = Colors.red;
  static Color success = Colors.green;
}

toast(String msg, Color toastType) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: toastType,
    textColor: Colors.white,
  );
}
