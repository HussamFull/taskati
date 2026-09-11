import 'package:flutter/material.dart';
import 'package:taskati/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    this.onDismissed,
  });

  final TaskModel task;

  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.key),

      onDismissed: onDismissed,

      direction: DismissDirection.horizontal,

      // ------------------------------------------------------
      // Swipe Right
      // ------------------------------------------------------

      background: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),

        alignment: Alignment.centerLeft,

        padding: const EdgeInsets.only(left: 20),

        child: const Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 30,
        ),
      ),

      // ------------------------------------------------------
      // Swipe Left
      // ------------------------------------------------------

      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),

        alignment: Alignment.centerRight,

        padding: const EdgeInsets.only(right: 20),

        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),

      // ------------------------------------------------------
      // Task
      // ------------------------------------------------------

      child: Container(
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          color: Color(task.color),
        ),

        child: Row(
          children: [

            // ------------------------------------------------
            // Task Information
            // ------------------------------------------------

            Expanded(
              child: Column(
                spacing: 5,

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    task.taskTitle,

                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,
                  ),

                  Text(
                    "${task.startTime} - ${task.endTime}",

                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,
                  ),

                  Text(
                    task.description,

                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            // ------------------------------------------------
            // Divider
            // ------------------------------------------------

            Container(
              height: 50,
              width: 2,
              color: Colors.white,
            ),

            // ------------------------------------------------
            // Status
            // ------------------------------------------------

            RotatedBox(
              quarterTurns: 3,

              child: Text(
                task.status,

                style: const TextStyle(
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