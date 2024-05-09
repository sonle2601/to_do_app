import 'package:flutter/material.dart';
import 'package:to_do_app/blocs/bloc_exports.dart';

import '../models/task.dart';
import '../services/guid_gen.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  EditTaskScreen({
    super.key,
    required this.oldTask,
  });






   @override
  Widget build(BuildContext context) {

     final titleController = TextEditingController(text: oldTask.title);
     final descriptionController = TextEditingController(text:  oldTask.description);
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
                var editedTask = Task(
                    date: DateTime.now().toString(),
                    description: descriptionController.text,
                    title: titleController.text,
                    id: oldTask.id,
                    isDone: false,
                    isFavorite: oldTask.isFavorite
                );
                context.read<TasksBloc>().add(EditTask(oldTask: oldTask, newTask: editedTask));
                Navigator.pop(context);
                }, child: const Text('Save'),
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
