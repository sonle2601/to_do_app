import 'package:flutter/material.dart';
import 'package:to_do_app/blocs/bloc_exports.dart';

import '../models/task.dart';

class AddTaskScreen extends StatelessWidget {
   AddTaskScreen({
    super.key,
  });

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Add Task',
            style: TextStyle(
                fontSize: 24
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
                label: Text('Lable'),
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                var task = Task(
                    title: titleController.text
                );
                context.read<TasksBloc>().add(AddTask(task: task));
                Navigator.pop(context);
                }, child: const Text('Add'),
              ),
              TextButton(onPressed: (){
                Navigator.pop(context);
                }, child: const Text('Cancel')
              ),
            ],
          )
        ],
      ),
    );
  }
}
