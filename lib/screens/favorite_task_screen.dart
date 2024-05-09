import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/bloc_exports.dart';
import 'package:to_do_app/screens/complete_task_screen.dart';
import 'package:to_do_app/screens/my_drawer.dart';
import 'package:to_do_app/screens/pending_screen.dart';

import '../models/task.dart';
import '../widget/tasks_list.dart';
import 'add_task_screen.dart';

class FavoriteTasksScreen extends StatelessWidget {
  FavoriteTasksScreen({Key? key}) : super(key: key);
    static const id = 'favorite_tasks_screen';



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
          List<Task> tasksList = state.favoriteTasks;
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


