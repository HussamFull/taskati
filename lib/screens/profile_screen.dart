import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/app_string.dart';
import 'package:taskati/models/user_model.dart';
import 'package:taskati/widgets/custom_auth_elevated_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.user});

  final UserModel? user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ------------------------------------------------------------
  // Colors
  // ------------------------------------------------------------

  static const Color primaryColor = Color(0xff4E5AE8);
  static const Color darkColor = Color(0xff1F2937);
  static const Color lightBackground = Color(0xffF7F8FC);
  static const Color lightPurple = Color(0xffEEF0FF);

  // ------------------------------------------------------------
  // User
  // ------------------------------------------------------------

  UserModel? user;

  // ------------------------------------------------------------
  // Image Picker
  // ------------------------------------------------------------

  final ImagePicker picker = ImagePicker();

  XFile? photo;

  // ------------------------------------------------------------
  // Controllers
  // ------------------------------------------------------------

  final TextEditingController nameController = TextEditingController();

  // ------------------------------------------------------------
  // Init
  // ------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    user = widget.user ?? Hive.box<UserModel>(AppString.userBox).getAt(0);
  }

  // ------------------------------------------------------------
  // Dispose
  // ------------------------------------------------------------

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------
  // Camera
  // ------------------------------------------------------------

  Future<void> openCamera() async {
    final XFile? selectedPhoto = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (selectedPhoto == null || user == null) {
      return;
    }

    user!.image = selectedPhoto.path;

    await user!.save();

    if (!mounted) return;

    setState(() {});

    Navigator.pop(context);
  }

  // ------------------------------------------------------------
  // Gallery
  // ------------------------------------------------------------

  Future<void> openGallery() async {
    final XFile? selectedPhoto = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (selectedPhoto == null || user == null) {
      return;
    }

    user!.image = selectedPhoto.path;

    await user!.save();

    if (!mounted) return;

    setState(() {});

    Navigator.pop(context);
  }

  // ------------------------------------------------------------
  // Image Picker Bottom Sheet
  // ------------------------------------------------------------

  void showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 45,
                height: 5,
                margin: const EdgeInsets.only(bottom: 22),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              // Title
              const Text(
                "Change Profile Picture",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Choose where you want to get your photo from",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  // Camera
                  Expanded(
                    child: _imageOption(
                      icon: Icons.camera_alt_rounded,
                      title: "Camera",
                      subtitle: "Take a photo",
                      onTap: openCamera,
                    ),
                  ),

                  const SizedBox(width: 14),

                  // Gallery
                  Expanded(
                    child: _imageOption(
                      icon: Icons.photo_library_rounded,
                      title: "Gallery",
                      subtitle: "Choose a photo",
                      onTap: openGallery,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // Image Option
  // ------------------------------------------------------------

  Widget _imageOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: lightPurple,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryColor.withOpacity(0.08)),
        ),
        child: Column(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: Colors.white, size: 27),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: darkColor,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Edit Name
  // ------------------------------------------------------------

  void showEditNameSheet() {
    nameController.text = user?.name ?? "";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 22),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                const Text(
                  "Edit Your Name",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: darkColor,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  "Update your name shown in the app",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),

                const SizedBox(height: 22),

                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    prefixIcon: const Icon(
                      Icons.person_outline_rounded,
                      color: primaryColor,
                    ),
                    filled: true,
                    fillColor: lightBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: CustomAuthElevatedButton(
                    text: "Update Your Name",
                    onPressed: () async {
                      final newName = nameController.text.trim();

                      if (newName.isEmpty || user == null) {
                        return;
                      }

                      user!.name = newName;

                      await user!.save();

                      if (!mounted) return;

                      setState(() {});

                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // Profile Image
  // ------------------------------------------------------------

  Widget _buildProfileImage() {
    final bool hasImage =
        user != null &&
        user!.image.isNotEmpty &&
        File(user!.image).existsSync();

    return Container(
      width: 145,
      height: 145,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: lightPurple,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.18),
            blurRadius: 25,
            spreadRadius: 3,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(5),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: hasImage ? FileImage(File(user!.image)) : null,
        child: !hasImage
            ? const Icon(Icons.person_rounded, size: 70, color: primaryColor)
            : null,
      ),
    );
  }

  // ------------------------------------------------------------
  // Camera Button
  // ------------------------------------------------------------

  Widget _buildCameraButton() {
    return Positioned(
      right: 3,
      bottom: 5,
      child: GestureDetector(
        onTap: showImagePickerSheet,
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.camera_alt_rounded,
            color: Colors.white,
            size: 21,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Profile Info Card
  // ------------------------------------------------------------

  Widget _buildProfileInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Name
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: lightPurple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: primaryColor,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      user?.name ?? "User",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: darkColor,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: showEditNameSheet,
                style: IconButton.styleFrom(backgroundColor: lightPurple),
                icon: const Icon(
                  Icons.edit_rounded,
                  color: primaryColor,
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Divider(color: Colors.grey.shade200, height: 1),

          const SizedBox(height: 18),

          // Profile Status
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xffE9F9F0),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Color(0xff21A366),
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile Status",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Active",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff21A366),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffE9F9F0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Active",
                  style: TextStyle(
                    color: Color(0xff21A366),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Build
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,

      body: SafeArea(
        child: Column(
          children: [
            // ====================================================
            // Header
            // ====================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: Row(
                children: [
                  // Back
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: lightPurple,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: primaryColor,
                        size: 19,
                      ),
                    ),
                  ),

                  const Expanded(
                    child: Text(
                      "My Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: darkColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Balance the header
                  const SizedBox(width: 45),
                ],
              ),
            ),

            // ====================================================
            // Content
            // ====================================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: Column(
                  children: [
                    // ==================================================
                    // Profile Picture
                    // ==================================================

                    Stack(
                      clipBehavior: Clip.none,
                      children: [_buildProfileImage(), _buildCameraButton()],
                    ),

                    const SizedBox(height: 22),

                    // ==================================================
                    // Welcome Text
                    // ==================================================
                    Text(
                      user?.name ?? "Welcome",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: darkColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Text(
                      "Manage your profile information",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ==================================================
                    // Profile Information
                    // ==================================================
                    _buildProfileInfo(),

                    const SizedBox(height: 20),

                    // ==================================================
                    // Change Photo Card
                    // ==================================================
                    InkWell(
                      onTap: showImagePickerSheet,
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xff4E5AE8), Color(0xff6873F0)],
                          ),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.20),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),

                            const SizedBox(width: 15),

                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Change Profile Photo",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    "Camera or Gallery",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ==================================================
                    // Footer
                    // ==================================================
                    Text(
                      "Taskati • Organize your day",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*

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




 */