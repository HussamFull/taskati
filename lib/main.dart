import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/app_string.dart';
import 'package:taskati/models/user_model.dart';
import 'taskati.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(AppString.userBox);

  runApp( Taskati());
}
