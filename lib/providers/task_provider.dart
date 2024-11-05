import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/repository/supabase_repository.dart';

class TaskProvider with ChangeNotifier {
  final SupabaseRepository _repo = SupabaseRepository();

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  double get taskCompletionProgress {
    if (_tasks.isEmpty) return 0;
    final completedTasks = _tasks.where((task) => task.isCompleted).length;
    return completedTasks / _tasks.length;
  }

  Future<void> listTasksByGroup(String groupId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await _repo.listTasksByGroup(groupId);
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

 
  Future<void> completeTask(Task task) async {
    try {
      task.isCompleted = !task.isCompleted;
      await _repo.updateTask(task);
      notifyListeners();
    } catch (e) {
      print("Erro ao atualizar tarefa: $e");
    }
  }
  Future<void> createTask(Task task) async {
    try {
      await _repo.createTask(task);
      _tasks.add(task);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _repo.deleteTask(taskId);
      _tasks.removeWhere((task) => task.id == taskId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
