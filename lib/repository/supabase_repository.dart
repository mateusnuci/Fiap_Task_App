import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task_group.dart';

class SupabaseRepository {
    Future<List<TaskGroup>> listTaskGroup() async {
        final client = Supabase.instance.client;
        final response = await client.from('task_groups').select();
        final tasksGroups = response.map((m) => TaskGroup.fromMap(m)).toList();
        return tasksGroups;
    }
}