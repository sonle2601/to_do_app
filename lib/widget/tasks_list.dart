import 'package:flutter/material.dart';
import 'package:to_do_app/blocs/bloc_exports.dart';
import 'package:to_do_app/widget/task_title.dart';

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
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: taskList.map((task) => ExpansionPanelRadio(
            value: task.id,
            headerBuilder: (context, isOpen) => TaskTitle(task: task),
            body: ListTile(
              title: SelectableText.rich(TextSpan(
                children: [
                  TextSpan(
                    text: 'Text: \n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(text: task.title),
                  TextSpan(
                      text: '\n\nDescription: \n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                  ),
                  TextSpan(text: task.description),
                ]
              )),
            )
          )).toList(),
        ),
      ),
    );
  }
}

// Expanded(
// child: ListView.builder(
// itemCount: taskList.length,
// itemBuilder: (context, index){
// var task = taskList[index];
// return TaskTitle(task: task);
// }),
// )
