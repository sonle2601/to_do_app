import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/widget/popup_menu.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../screens/edit_task_screen.dart';

class TaskTitle extends StatelessWidget {
  const TaskTitle({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task){
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }
  void _editTask(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context)  {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: EditTaskScreen(oldTask: task,),
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                  ? Icon(Icons.star_outline)
                  : Icon(Icons.star),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        decoration: task.isDone! ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Text(
                        DateFormat()
                            .add_yMMMd()
                            .add_Hms()
                            .format(DateTime.parse(task.date))),
                  ],
                ),
              ],
            ),
          ),

          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false ?(value){
                context.read<TasksBloc>().add(UpdateTask(task: task));
                  } : null
                ),
              PopupMenu(
                task: task,
                cancelOrDeleteCallback:()  {
                  _removeOrDeleteTask(context, task);
                  Navigator.pop(context);
                },
                likeOrDislike: ()  {
                  context.read<TasksBloc>().add(
                    MarkFavoriteOrUnfavoriteTask(task: task),
                  );
                  Navigator.pop(context);
                },
                editTaskCallback: (){
                  Navigator.pop(context);
                  _editTask(context);
                  // Navigator.pop(context);
                }, restoreTaskCallback: () {
                Navigator.pop(context);
                context.read<TasksBloc>().add(RestoreTask(task: task));
              },
              )
            ],
          ),
        ],
      ),
    );
  }
}



// ListTile(
// title: Text(
// task.title,
// overflow: TextOverflow.ellipsis,
// style: TextStyle(
// decoration: task.isDone! ? TextDecoration.lineThrough : null,
// ),
// ),
// trailing: Checkbox(
// value: task.isDone,
// onChanged: task.isDeleted == false ?(value){
// context.read<TasksBloc>().add(UpdateTask(task: task));
// } : null
// ),
// onLongPress: () =>
// _removeOrDeleteTask(context, task)
// ,
// );