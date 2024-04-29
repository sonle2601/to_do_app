import 'package:flutter/material.dart';
import 'package:to_do_app/blocs/bloc_exports.dart';

import '../models/task.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.taskList,
  });

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index){
            var task = taskList[index];
            return ListTile(
              title: Text(task.title),
              trailing: Checkbox(
                value: task.isDone,
                onChanged: (value){
                  context.read<TasksBloc>().add(UpdateTask(task: task));
                },
              ),
              onLongPress: () =>
                context.read<TasksBloc>().add(DeleteTask(task: task))
              ,
            );
          }),
    );
  }
}
