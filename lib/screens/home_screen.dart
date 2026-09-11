import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/app_string.dart';
import 'package:taskati/models/task_model.dart';
import 'package:taskati/models/user_model.dart';
import 'package:taskati/screens/add_task_screen.dart';
import 'package:taskati/widgets/date_addtask.dart';
import 'package:taskati/widgets/date_container.dart';
import 'package:taskati/widgets/home_app_bar.dart';
import 'package:taskati/widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Box<TaskModel> myBox =
      Hive.box<TaskModel>(AppString.taskBox);

  UserModel? user =
      Hive.box<UserModel>(AppString.userBox).getAt(0);

  final List<String> statusList = [
    "All",
    "Complete",
    "TODO",
  ];

  int selectedIndex = 0;

  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // ----------------------------------------------------------
  // Load Tasks
  // ----------------------------------------------------------

  void loadTasks() {
    final allTasks = myBox.values.toList();

    if (selectedIndex == 0) {
      tasks = List<TaskModel>.from(allTasks);
    } else if (selectedIndex == 1) {
      tasks = allTasks
          .where((task) => task.status == "Complete")
          .toList();
    } else {
      tasks = allTasks
          .where((task) => task.status == "TODO")
          .toList();
    }
  }

  // ----------------------------------------------------------
  // Delete Task
  // ----------------------------------------------------------

  Future<void> deleteTask(TaskModel task) async {
    // IMPORTANT:
    // Remove immediately from the displayed list.
    setState(() {
      tasks.removeWhere(
        (item) => item.key == task.key,
      );
    });

    // Then remove it from Hive.
    await myBox.delete(task.key);
  }

  // ----------------------------------------------------------
  // Update Task Status
  // ----------------------------------------------------------

  Future<void> updateTaskStatus(TaskModel task) async {
    // Change status first.
    task.status = "Complete";

    // Save the change to Hive.
    await task.save();

    // Remove it immediately from the current displayed list
    // if the current filter should no longer contain it.
    setState(() {
      tasks.removeWhere(
        (item) => item.key == task.key,
      );
    });
  }

  // ----------------------------------------------------------
  // Change Filter
  // ----------------------------------------------------------

  void changeStatus(int index) {
    setState(() {
      selectedIndex = index;
      loadTasks();
    });
  }

  // ----------------------------------------------------------
  // Build
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          child: ListView(
            children: [

              // ------------------------------------------------
              // App Bar
              // ------------------------------------------------

              HomeAppBar(
                user: user,
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // Add Task
              // ------------------------------------------------

              DateAndAddTask(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AddTaskScreen(),
                    ),
                  );

                  if (!mounted) return;

                  setState(() {
                    loadTasks();
                  });
                },
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // Status Buttons
              // ------------------------------------------------

              Row(
                children: List.generate(
                  statusList.length,
                  (index) {
                    return DateContainer(
                      statusText: statusList[index],

                      isActive:
                          index == selectedIndex,

                      onTap: () {
                        changeStatus(index);
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // Empty / Tasks
              // ------------------------------------------------

              if (tasks.isEmpty)

                Lottie.asset(
                  "assets/images/Empty_box.json",
                )

              else

                ListView.separated(
                  shrinkWrap: true,

                  physics:
                      const NeverScrollableScrollPhysics(),

                  itemCount: tasks.length,

                  separatorBuilder:
                      (context, index) =>
                          const SizedBox(height: 10),

                  itemBuilder:
                      (context, index) {

                    final task = tasks[index];

                    return TaskItem(
                      key: ValueKey(task.key),

                      task: task,

                      onDismissed:
                          (direction) {

                        if (direction ==
                            DismissDirection.startToEnd) {

                           // Green → Complete
    updateTaskStatus(task);

                        } else {

                            // Red → Delete
    deleteTask(task);
                        }
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}