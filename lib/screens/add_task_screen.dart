import 'package:flutter/material.dart';
import 'package:taskati/widgets/custom_add_task_felid.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff4e5ae8)),
        titleTextStyle: TextStyle(
          color: Color(0xff4e5ae8),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: Text('Add Task'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Form(
          child: Column(
            children: [
              Text(
                'Title',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomAddTaskField(
                hintText: 'Enter task title',
                readOnly: false,
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                },
              ),
              SizedBox(height: 10.0),

              Text(
                'Description',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomAddTaskField(
                hintText: 'Enter task description',

                controller: descriptionController,
                maxLine: 3,
                readOnly: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                },
              ),
              SizedBox(height: 10.0),
              Text(
                'Date',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomAddTaskField(
                hintText: '2026-01-01',
                suffixIcon: InkWell(
                  child: Icon(Icons.date_range),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      barrierDismissible: false, // Prevents closing the date picker by tapping outside
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        // Update the text field with the selected date
                        setState(() {
                          // Format the date as needed
                          String formattedDate =
                              "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                          // Update the controller's text
                          dateController.text = formattedDate;
                          // 22,12 min vin vedio
                        });
                      }
                    });
                  },
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                },
              ),

              SizedBox(height: 10.0),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Start Time",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        CustomAddTaskField(
                          hintText: '10:00 AM',
                          readOnly: true,
                          suffixIcon: InkWell(
                            child: Icon(Icons.alarm),
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((selectedTime) {
                                if (selectedTime != null) {
                                  // Update the text field with the selected time
                                  setState(() {
                                    String formattedTime = selectedTime.format(
                                      context,
                                    );
                                    // Update the controller's text
                                    startTimeController.text = formattedTime;
                                    // 28 min vin vedio
                                  });
                                }
                              });
                            },
                          ),
                          controller: startTimeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a start time';
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "End Time",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        CustomAddTaskField(
                          hintText: '10:00 PM',
                          readOnly: true,
                          suffixIcon: InkWell(
                            child: Icon(Icons.alarm),
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((selectedTime) {
                                if (selectedTime != null) {
                                  // Update the text field with the selected time
                                  setState(() {
                                    String formattedTime = selectedTime.format(
                                      context,
                                    );
                                    // Update the controller's text
                                    endTimeController.text = formattedTime;
                                    // 28 min vin vedio
                                  });
                                }
                              });
                            },
                          ),
                          controller: endTimeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an End time';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
