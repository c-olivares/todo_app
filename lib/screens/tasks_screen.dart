import 'package:flutter/material.dart';
import 'package:todoey/screens/add_task_screen.dart';
import '../widgets/taskslist.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

class TasksScreen extends StatelessWidget {
  Widget buildBottomSheet(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: CircleAvatar(
        radius: 35.0,
        child: FloatingActionButton.large(
          child: Icon(
            size: 35.0,
            Icons.library_add_check,
            color: Colors.white,
          ),
          backgroundColor: Colors.purple[400],
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddTaskScreen(),
                      ),
                    ));
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/fondo.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            padding: (EdgeInsets.only(
              top: 60.0,
              left: 30.0,
              right: 30.0,
              bottom: 10.0,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    color: Colors.purple[400],
                    size: 30.0,
                  ),
                  radius: 30.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  "PlanifiKT",
                  style: TextStyle(
                    backgroundColor: Colors.white,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 40.0,
                  ),
                ),
                Text(
                  "${Provider.of<TaskData>(context).taskCount} Tareas - Dejar presionado para borrar.",
                  style: TextStyle(
                      color: Colors.purple[400],
                      fontSize: 18.0,
                      backgroundColor: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/apuntes.webp"), fit: BoxFit.cover),
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
            ),
            child: TasksList(),
          )),
        ],
      ),
    );
  }
}
