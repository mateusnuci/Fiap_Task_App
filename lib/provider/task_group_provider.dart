import 'package:flutter/material.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/repository/supabase_repository.dart';

class TaskGroupProvider extends ChangeNotifier {
  final supabaseRepo = SupabaseRepository();
  bool _isloading = false;
  bool get isLoading => _isloading;


  List<TaskGroup> _taskGroups = [];
  List<TaskGroup> get taskGroups => _taskGroups;


  Future<void> listTaskGroups() async {
    try {
      _isloading = true;
      notifyListeners();
      _taskGroups = await supabaseRepo.listTaskGroup();
    } catch (e) {

    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

} 