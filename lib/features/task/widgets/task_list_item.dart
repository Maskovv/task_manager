import 'package:flutter/material.dart';
import '../model/task_model.dart';
import 'package:intl/intl.dart';

class TaskListItem extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onToggleComplete;
  final VoidCallback onDelete;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onToggleComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.description),
          Text(
            'Срок: ${DateFormat('d MMMM y', 'ru').format(task.dueDate)}',
            style: TextStyle(
              color: task.dueDate.isBefore(DateTime.now()) && !task.isCompleted
                  ? Colors.red
                  : Colors.grey,
            ),
          ),
        ],
      ),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (_) => onToggleComplete(),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}