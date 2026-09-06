import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskati/app_string.dart';
import 'package:taskati/models/user_model.dart';
import 'package:taskati/screens/auth_screen.dart';
import 'package:taskati/screens/profile_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                'Hello, ${user?.name ?? ' '}',
                style: TextStyle(
                  color: Color(0xff4e5ae8),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'have a nice day!',
                style: TextStyle(
                  color: Color(0xff4e5ae8),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),

        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(user: user),
              ),
            );
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: (user != null && user!.image.isNotEmpty)
                ? FileImage(File(user!.image))
                : null,
            backgroundColor: Color(0xff121212),
          ),
        ),

        // logout button
        IconButton(
          onPressed: () {
            Hive.box<UserModel>(AppString.userBox).clear();
            Navigator.pushNamedAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => AuthScreen()) as String,
              (route) => false,
            );
          },
          icon: Icon(Icons.logout, color: Colors.red),
        ),
      ],
    );
  }
}
