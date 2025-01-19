import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTaskScreen extends StatelessWidget {
  final Function addTaskCallback;
  AddTaskScreen(this.addTaskCallback);
  late String newTaskTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add Task",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blueGrey, fontSize: 30.0),
          ),
          TextField(
            cursorColor: Colors.blueGrey,
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newTaskTitle = newText;
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueGrey,
              shape: BeveledRectangleBorder(),
            ),
            child: const Text('Add'),
            onPressed: () {
              addTaskCallback(newTaskTitle);
            },
          ),
        ],
      ),
    );
  }
}
