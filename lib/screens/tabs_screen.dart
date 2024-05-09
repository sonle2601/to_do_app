import 'package:flutter/material.dart';
import 'package:to_do_app/screens/my_drawer.dart';
import 'package:to_do_app/screens/pending_screen.dart';
import 'package:to_do_app/screens/tasks_screen.dart';

import 'add_task_screen.dart';
import 'complete_task_screen.dart';
import 'favorite_task_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName' : PendingScreen(), 'title' : 'Pending Tasks'},
    {'pageName' : CompleteTasksScreen(), 'title' : 'Complete Tasks'},
    {'pageName' : FavoriteTasksScreen(), 'title' : 'Favorite Tasks'},
  ];

  var _selectedPageIndex = 0;

  void _addText(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageDetails[_selectedPageIndex]['title']
        ),
        actions: [
          IconButton(
            onPressed: () {
              _addText(context);
            },
            icon: const Icon(Icons.add),
          )
        ],

      ),
      drawer: MyDrawer(),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0 ?
      FloatingActionButton(
        onPressed: () {
          _addText(context);
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      )
      : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index){
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.incomplete_circle),
            label: 'Pending Tasks'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: 'Complete Tasks'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite Tasks'
          ),
        ],
      ),
    );
  }
}
