import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/bloc_exports.dart';
import 'package:to_do_app/screens/my_drawer.dart';

import '../models/task.dart';
import '../widget/tasks_list.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
    TasksScreen({Key? key}) : super(key: key);
    static const id = 'tasks_screen';


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
          List<Task> tasksList = state.pendingTasks;
          return  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [

                Center(
                  child: Chip(
                    label: Text(
                      '${tasksList.length} Tasks'
                    ),
                  ),
                ),
                TasksList(taskList: tasksList)
              ],
          );
        }
    );
  }
}


