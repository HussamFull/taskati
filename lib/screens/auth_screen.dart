
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/app_string.dart';
import 'package:taskati/models/user_model.dart';
import 'package:taskati/screens/home_screen.dart';
import 'package:taskati/widgets/custom_auth_elevated_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ImagePicker picker = ImagePicker();

  XFile? photo;

  final TextEditingController nameController = TextEditingController();

  Future<void> openCamera() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        photo = pickedFile;
      });
    }
  }

  Future<void> openGallery() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        photo = pickedFile;
      });
    }
  }

  Future<void> addUser() async {
    try {
      final box = Hive.box<UserModel>(AppString.userBox);

      await box.clear();

      await box.add(
        UserModel(
          name: nameController.text,
          image: photo?.path ?? '',
        ),
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to add user: $e'),
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
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile image
                photo == null
                    ? const CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xff121212),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Color(0xff4E5AE8),
                        ),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0xff121212),
                        backgroundImage: FileImage(
                          File(photo!.path),
                        ),
                      ),

                const SizedBox(height: 15),

                CustomAuthElevatedButton(
                  text: "Upload from Camera",
                  onPressed: openCamera,
                ),

                const SizedBox(height: 15),

                CustomAuthElevatedButton(
                  text: "Upload from Gallery",
                  onPressed: openGallery,
                ),

                const SizedBox(height: 10),

                const Divider(
                  color: Colors.grey,
                  thickness: 3,
                ),

                const SizedBox(height: 10),

                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xff4E5AE8),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                CustomAuthElevatedButton(
                  text: "Submit",
                  onPressed: () {
                    if (photo == null) {
                      return;
                    }

                    if (nameController.text.trim().isEmpty) {
                      return;
                    }

                    addUser();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

