import 'package:flutter/material.dart';
import 'package:patient_management_system/const/constant.dart';
import 'package:patient_management_system/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashborad UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: mbackgroundColor,
        brightness: Brightness.dark,
      ),
      home: const MainScreen(),
    );
  }
}
