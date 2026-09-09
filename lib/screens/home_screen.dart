import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/app_string.dart';
import 'package:taskati/models/task_model.dart';
import 'package:taskati/models/user_model.dart';
import 'package:taskati/screens/add_task_screen.dart';
import 'package:taskati/widgets/date_addtask.dart';
import 'package:taskati/widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? user = Hive.box<UserModel>(AppString.userBox).getAt(0);
  List<String> statusList = ["All", "Complete", "TODO"];
  int selectedIndex = 0;
  List<TaskModel> tasks = [];

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 0) {
      tasks = Hive.box<TaskModel>(AppString.taskBox).values.toList();
    } else if (selectedIndex == 1) {
      tasks = Hive.box<TaskModel>(AppString.taskBox).values
          .toList()
          .where((e) => e.status == "Complete")
          .toList();
    } else if (selectedIndex == 2) {
      tasks = Hive.box<TaskModel>(AppString.taskBox).values
          .toList()
          .where((e) => e.status == "TODO")
          .toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            HomeAppBar(user: user),
            SizedBox(height: 20),
            DateAndAddTask(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTaskScreen()),
                );
              },
            ),
          ],
        ),
      ),
      )
    );
  }
}
