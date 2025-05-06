import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final Todo task;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;
  final Function(BuildContext)? editTask;

  const ToDoTile({
    super.key,
    required this.onChanged,
    required this.deleteTask,
    required this.task,
    this.editTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editTask,
              icon: Icons.edit,
              label: 'Edit',
              backgroundColor: Colors.yellow.shade800,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              label: 'Delete',
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),

          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              Checkbox(
                value: task.taskDone,
                onChanged: onChanged,
                activeColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              Expanded(
                child: Text(
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  task.name,
                  style: TextStyle(
                    decoration:
                        task.taskDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
