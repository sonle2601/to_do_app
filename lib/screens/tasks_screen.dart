import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/bloc_exports.dart';

import '../models/task.dart';
import '../widget/tasks_list.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
    TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
   void _addText(BuildContext context){
     showModalBottomSheet(
         context: context,
         builder: (context) => SingleChildScrollView(
           child: Container(
                padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
               ),
               child: AddTaskScreen(),
           ),
         )
     );
   }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state){
          List<Task> tasksList = state.allTasks;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tasks App'),
              actions: [
                IconButton(
                  onPressed: () {
                    _addText(context);
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [

                Center(
                  child: Chip(
                    label: Text(
                      'Tasks:',
                    ),
                  ),
                ),
                TasksList(taskList: tasksList)
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _addText(context);
              },
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            ),
          );
        }
    );
  }
}


