import 'package:hive_flutter/hive_flutter.dart';

part 'task_model.g.dart';
@HiveType(typeId: 1)

class TaskModel {
   TaskModel({
    required this.taskTitle,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.color ,
  });

  @HiveField(0)
  final String taskTitle;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String startTime;
  @HiveField(4)
  final String endTime;
  @HiveField(5)
   String status;
  @HiveField(6)
  int color;

 
}
