import 'package:flutter/material.dart';
import 'package:to_do_app/screens/recycle_bin.dart';
import 'package:to_do_app/screens/tabs_screen.dart';
import 'package:to_do_app/screens/tasks_screen.dart';

import '../blocs/bloc_exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              color: Colors.grey,
              child: Text(
                'Text Drawer',
                style: TextStyle(
                    fontSize: 18
                ),
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(
                          TabsScreen.id
                      ),
                  child: ListTile(
                    leading: Icon(Icons.folder),
                    title: Text(
                        'My Tasks'
                    ),
                    trailing: Text('${state.pendingTasks.length}'),
                  ),
                );
              },
            ),
            Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        RecycleBin.id
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text(
                        'Bin'
                    ),
                    trailing: Text('${state.removedTasks.length}'),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.colorize),
              title: Text('Type Screen'),
              trailing: BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Switch(
                    value: state.switchValue,
                    onChanged: (newValue) {
                      newValue
                          ? context.read<SwitchBloc>().add(SwitchOnEvent())
                          : context.read<SwitchBloc>().add(SwitchOffEvent());
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
