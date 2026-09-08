import 'package:flutter/material.dart';

class DateAndAddTask extends StatelessWidget {
  const DateAndAddTask({
    super.key,
    this.onPressed,
    
  });

  final void Function()? onPressed;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
           "Septemper 12, 2026",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff4e5ae8),
              foregroundColor: Colors.white,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              children: [
                Icon(Icons.add),
                SizedBox(width: 10),
                Text('Add Task', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
