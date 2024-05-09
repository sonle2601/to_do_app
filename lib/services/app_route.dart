import 'package:flutter/material.dart';
import 'package:to_do_app/screens/recycle_bin.dart';
import 'package:to_do_app/screens/tabs_screen.dart';
import 'package:to_do_app/screens/tasks_screen.dart';

class AppRoute{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch  (routeSettings.name){
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => RecycleBin());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => TabsScreen());
      default :
        return null;
    }
  }

}