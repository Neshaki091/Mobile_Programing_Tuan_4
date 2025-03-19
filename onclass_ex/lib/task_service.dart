import 'dart:convert';
import 'package:http/http.dart' as http;
import 'task_model.dart';

class TaskService {
  final String baseUrl = "https://amock.io/api/researchUTH";

  // Lấy danh sách tất cả các task
  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse("$baseUrl/tasks"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Kiểm tra nếu API trả về thành công và có dữ liệu
      if (jsonData['isSuccess'] == true && jsonData['data'] is List) {
        return (jsonData['data'] as List)
            .map((task) => Task.fromJson(task))
            .toList();
      } else {
        throw Exception("No task data available");
      }
    } else {
      throw Exception("Failed to load tasks: ${response.statusCode}");
    }
  }

  // Lấy chi tiết một task theo ID
  Future<Task> fetchTaskDetail(int taskId) async {
    final response = await http.get(Uri.parse("$baseUrl/task/$taskId"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Kiểm tra nếu API trả về thành công và có dữ liệu
      if (jsonData['isSuccess'] == true && jsonData['data'] != null) {
        return Task.fromJson(jsonData['data']);
      } else {
        throw Exception("No task detail available");
      }
    } else {
      throw Exception("Failed to load task detail: ${response.statusCode}");
    }
  }

  // Xóa một task
  Future<void> deleteTask(int taskId) async {
    final response = await http.delete(Uri.parse("$baseUrl/task/$taskId"));

    if (response.statusCode == 200) {
      print("Task deleted successfully");
    } else {
      throw Exception("Failed to delete task: ${response.statusCode}");
    }
  }
}
