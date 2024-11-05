import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.task, required this.color});
  final Task task;
  final Color color;
  

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false); 
    return ListTile(
      onTap: () {
        
      },
      leading: GestureDetector(
        onTap: () {
          provider.completeTask(widget.task);
          
          /*setState(() {
            widget.task.isCompleted = widget.task.isCompleted ? false : true;
            
        });
        */
        }, 
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          decoration: BoxDecoration(
            color: widget.task.isCompleted ? widget.color : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: .8),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        widget.task.title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.task.subtitle,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                top: 10,
              ),
              child: Text(
                DateFormat.yMMMEd().format(widget.task.date),
                style: TextStyle(
                  fontSize: 12,
                  color: widget.task.isCompleted ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
