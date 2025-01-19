import 'package:flutter/material.dart';
import 'package:todoey/screens/add_task_screen.dart';
import '../widgets/taskslist.dart';
import 'package:todoey/models/task.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> tasks = [
    Task(name: 'Buy Milk'),
    Task(name: 'Buy Eggs'),
    Task(name: 'Buy Bread'),
  ];

  Widget buildBottomSheet(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      floatingActionButton: CircleAvatar(
        child: FloatingActionButton.large(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.purpleAccent,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddTaskScreen((newTaskTitle) {
                          setState(() {
                            tasks.add(Task(name: newTaskTitle));
                          });
                          Navigator.pop(context);
                        }),
                      ),
                    ));
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: (EdgeInsets.only(
              top: 60.0,
              left: 30.0,
              right: 30.0,
              bottom: 30.0,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    color: Colors.purpleAccent,
                    size: 30.0,
                  ),
                  radius: 30.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  "Todoey",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0,
                  ),
                ),
                Text(
                  "${tasks.length} Tasks",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
            ),
            child: TasksList(tasks),
          )),
        ],
      ),
    );
  }
}
