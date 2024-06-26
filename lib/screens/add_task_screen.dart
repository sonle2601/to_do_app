import 'package:flutter/material.dart';
import 'package:to_do_app/blocs/bloc_exports.dart';

import '../models/task.dart';
import '../services/guid_gen.dart';

class AddTaskScreen extends StatelessWidget {
   AddTaskScreen({
    super.key,
  });

  final titleController = TextEditingController();
   final descriptionController = TextEditingController();


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
          TextField(
            minLines: 3,
            maxLines: 5,
            autofocus: true,
            controller: descriptionController,
            decoration: const InputDecoration(
                label: Text('Description'),
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                var task = Task(
                    date: DateTime.now().toString(),
                    description: descriptionController.text,
                    title: titleController.text,
                    id: UUIDGenerator.generate(),
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
