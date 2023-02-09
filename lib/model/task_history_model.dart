// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaskHistoryModel extends Equatable {
  final int? id;
  final int taskId;
  final String date;
  final int rank;
  const TaskHistoryModel({
    required this.id,
    required this.taskId,
    required this.date,
    required this.rank,
  });
  @override
  List<Object?> get props => [id, taskId, date, rank];

  Map<String, dynamic> toMap() {
    return 
    id == null ?
    <String, dynamic>{
      'taskId': taskId,
      'date': date,
      'rank': rank,
    }:
    <String, dynamic>{
      'id': id,
      'taskId': taskId,
      'date': date,
      'rank': rank,
    };
  }

  factory TaskHistoryModel.fromMap(Map<String, dynamic> map) {
    return TaskHistoryModel(
      id: map['id'] as int,
      taskId: map['taskId'] as int,
      date: map['date'] as String,
      rank: map['rank'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskHistoryModel.fromJson(String source) => TaskHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
