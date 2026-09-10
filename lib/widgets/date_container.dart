import 'package:flutter/material.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({
    super.key,
    this.isActive = false,
    required this.statusText,
    this.onTap,


  });
  final bool isActive;
  final String statusText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? const Color(0xff4e5ae8) : const Color(0xff121212),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Center(
              child: Text(
                statusText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
