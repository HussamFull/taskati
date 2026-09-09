import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskati/app_string.dart';
import 'package:taskati/models/task_model.dart';
import 'package:taskati/widgets/custom_add_task_felid.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  int activeSelectedIndex = -1;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff4e5ae8)),
        title: const Text(
          'Add Task',
          style: TextStyle(
            color: Color(0xff4e5ae8),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              CustomAddTaskField(
                hintText: 'Enter task title',
                controller: titleController,
                readOnly: false,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              const Text(
                'Description',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              CustomAddTaskField(
                hintText: 'Enter task description',
                controller: descriptionController,
                maxLine: 3,
                readOnly: false,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              const Text(
                'Date',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              CustomAddTaskField(
                hintText: '2026-01-01',
                controller: dateController,
                readOnly: true,
                suffixIcon: InkWell(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (selectedDate != null) {
                      final formattedDate =
                          '${selectedDate.year}-'
                          '${selectedDate.month.toString().padLeft(2, '0')}-'
                          '${selectedDate.day.toString().padLeft(2, '0')}';

                      dateController.text = formattedDate;
                    }
                  },
                  child: const Icon(Icons.date_range),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Start Time',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        CustomAddTaskField(
                          hintText: '10:00 AM',
                          controller: startTimeController,
                          readOnly: true,
                          suffixIcon: InkWell(
                            onTap: () async {
                              final selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (selectedTime != null) {
                                startTimeController.text = selectedTime.format(
                                  context,
                                );
                              }
                            },
                            child: const Icon(Icons.alarm),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a start time';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'End Time',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        CustomAddTaskField(
                          hintText: '10:00 PM',
                          controller: endTimeController,
                          readOnly: true,
                          suffixIcon: InkWell(
                            onTap: () async {
                              final selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (selectedTime != null) {
                                endTimeController.text = selectedTime.format(
                                  context,
                                );
                              }
                            },
                            child: const Icon(Icons.alarm),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an end time';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                'Color',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: List.generate(colors.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          activeSelectedIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(25),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: colors[index],
                        child: activeSelectedIndex == index
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate the form
                    if (!(formKey.currentState?.validate() ?? false)) {
                      return;
                    }

                    // Validate color selection
                    if (activeSelectedIndex == -1) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please choose a color.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );

                      return;
                    }

                    // Create task
                    final task = TaskModel(
                      taskTitle: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                      date: dateController.text,
                      startTime: startTimeController.text,
                      endTime: endTimeController.text,
                      color: colors[activeSelectedIndex].toARGB32(),
                      status: 'TODO',
                    );

                    // Save task to Hive
                    await Hive.box<TaskModel>(AppString.taskBox).add(task);

                    // Return to previous screen
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4e5ae8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Create Task',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
