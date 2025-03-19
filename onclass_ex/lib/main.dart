import 'package:flutter/material.dart';
import 'task_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTH SmartTasks',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskScreen(), // Màn hình chính hiển thị danh sách tasks
    );
  }
}
