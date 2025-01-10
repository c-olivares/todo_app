import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTaskScreen extends StatelessWidget {
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
            style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30.0),
          ),
          TextField(
            cursorColor: Colors.lightBlueAccent,
            autofocus: true,
            textAlign: TextAlign.center,
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightBlueAccent,
              shape: BeveledRectangleBorder(),
            ),
            child: const Text('Add'),
            onPressed: () {
              // ...
            },
          ),
        ],
      ),
    );
  }
}
