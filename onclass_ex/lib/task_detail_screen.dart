import 'package:flutter/material.dart';
import 'task_model.dart';
import 'task_service.dart';

class TaskDetailScreen extends StatefulWidget {
  final int taskId;
  TaskDetailScreen({required this.taskId});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final TaskService _taskService = TaskService();
  late Future<Task> _taskDetail;

  @override
  void initState() {
    super.initState();
    _taskDetail = _taskService.fetchTaskDetail(widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Detail")),
      body: FutureBuilder<Task>(
        future: _taskDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading task details"));
          } else {
            final task = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(task.description, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _taskService.deleteTask(task.id);
                      Navigator.pop(context); // Quay lại màn hình trước
                    },
                    child: Text("Delete Task"),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
