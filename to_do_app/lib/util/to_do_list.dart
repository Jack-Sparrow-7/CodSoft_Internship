import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class TaskItem extends StatelessWidget {
  final String? taskName;
  final String? taskDescription;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  VoidCallback editTask;
  TaskItem({
    super.key,
    required this.taskName,
    required this.taskDescription,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteTask,
    required this.editTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Slidable(
        enabled: true,
        endActionPane:
            ActionPane(motion: StretchMotion(), extentRatio: 0.3, children: [
          SlidableAction(
            onPressed: deleteTask,
            icon: Icons.delete,
            label: "Delete",
            backgroundColor: Colors.red.shade400,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ]),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            title: Text(
              taskName!,
              style: taskCompleted
                  ? TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough)
                  : TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
            ),
            subtitle: Text(taskDescription!),
            leading: Checkbox(value: taskCompleted, onChanged: onChanged),
            trailing: IconButton(
              onPressed: editTask,
              icon: Icon(
                Icons.edit,
                color: Colors.blue,
                size: 25,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
