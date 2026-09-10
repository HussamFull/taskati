import 'package:flutter/material.dart';
import 'package:taskati/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task,  this.onDismissed});

  final TaskModel task;
  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: onDismissed ,
      key: UniqueKey(),
      background: Container(
        height: 100,
        color: Colors.green,
        child: Icon(Icons.incomplete_circle, color: Colors.white),
      ),
      secondaryBackground: Container(
        height: 100,
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),


          color: Color(task.color),


        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    task.taskTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    "${task.startTime}-${task.endTime}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    task.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Container(height: 50, width: 2, color: Colors.white),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.status,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
