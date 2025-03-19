import 'package:flutter/material.dart';
import 'task_model.dart';
import 'task_service.dart';
import 'task_detail_screen.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskService _taskService = TaskService();
  late Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = _taskService.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List", style: TextStyle(fontSize: 20))),
      body: FutureBuilder<List<Task>>(
        future: _tasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading tasks"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildEmptyView();
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final task = snapshot.data![index];
                return _buildTaskCard(task, index);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/no_tasks.png", height: 150), // Icon trống
          SizedBox(height: 10),
          Text(
            "No Tasks Yet!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("Stay productive—add something to do"),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Task task, int index) {
    // Màu nền cho từng card
    List<Color> colors = [
      Colors.blue[200]!,
      Colors.red[200]!,
      Colors.green[200]!,
      Colors.purple[200]!,
    ];

    return Card(
      color: colors[index % colors.length],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        title: Text(task.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(task.description),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black54),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailScreen(taskId: task.id),
            ),
          );
        },
      ),
    );
  }
}
