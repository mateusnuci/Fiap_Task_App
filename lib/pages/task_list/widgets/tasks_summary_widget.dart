import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';

class TasksSummaryWidget extends StatelessWidget {
  const TasksSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final taskProgress = taskProvider.taskCompletionProgress;
    final totalTasks = taskProvider.tasks.length;
    final completedTasks = taskProvider.tasks.where((task) => task.isCompleted).length;

    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: const AlwaysStoppedAnimation(Colors.red),
              backgroundColor: Colors.grey,
              value: taskProgress, // Atualiza com o valor do Provider
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          /// Textos
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tasks',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "$completedTasks of $totalTasks task(s)", // Exibe o progresso de tarefas
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
