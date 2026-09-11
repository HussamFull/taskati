import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/app_string.dart';
import 'package:taskati/models/user_model.dart';
import 'package:taskati/widgets/custom_auth_elevated_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.user});

  /// The user model for the profile screen.
  final UserModel? user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user = Hive.box<UserModel>(AppString.userBox).get(0);

  final ImagePicker picker = ImagePicker();
  XFile? photo;
  TextEditingController nameController = TextEditingController();

  openCamera() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      user!.image = photo!.path;
      await user!.save();
    }
    setState(() {
      Navigator.pop(context);
    });
  }

  openGallery() async {
    photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      user!.image = photo!.path;
      await user!.save();
    }
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },

          child: Icon(Icons.arrow_back, color: Color(0xff4E5ae8)),
        ),
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xffB4AAAA),
                    radius: 50,
                    backgroundImage: (user != null && user!.image.isNotEmpty)
                        ? FileImage(File(user!.image))
                        : null,
                  ),

                  InkWell(
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: Color(0xff4e5ae8),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Padding(
                          padding: EdgeInsets.all(16),

                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  openCamera();
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Color(0xff4e5ae8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    " upload from Camera",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  openGallery();
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Color(0xff4e5ae8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    " upload from Gallery",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 20),

              Divider(),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user!.name,
                    style: TextStyle(
                      color: Color(0xff4e5ae8),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  label: Text(user!.name),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Color(0xff4e5ae8),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20),

                              CustomAuthElevatedButton(
                                text: "update Your Name",
                                onPressed: () async {
                                  if (nameController.text.isEmpty) return;
                                  user!.name = nameController.text;
                                  await user!.save();

                                  setState(() {
                                   
                                  });
                                   Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.update, color: Color(0xff4e5ae8)),
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
