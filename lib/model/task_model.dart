// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final int? id;
  final String title;
  final String description;
  final String status;
  final String category;
  final String startDate;
  final String endDate;
  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.category,
    required this.startDate,
    required this.endDate,
  });


  @override
  List<Object?> get props => [id, title, description, status, category, startDate, endDate];


  Map<String, dynamic> toMap() {
    return
    id == null ?
    <String, dynamic>{
      // 'id': id,
      'title': title,
      'description': description,
      'status': status,
      'category': category,
      'startDate': startDate,
      'endDate': endDate,
    }:    
     <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'category': category,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      category: map['category'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
