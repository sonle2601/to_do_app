import 'package:flutter/material.dart';
import 'package:to_do_app/screens/tabs_screen.dart';
import 'package:to_do_app/screens/tasks_screen.dart';
import 'package:to_do_app/services/app_route.dart';
import 'package:to_do_app/services/app_theme.dart';

import 'blocs/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MyApp(appRoute: AppRoute(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoute});

  final AppRoute appRoute;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: state.switchValue
              ? AppThemes.appThemeData[AppTheme.darkTheme]
              : AppThemes.appThemeData[AppTheme.lightTheme],
            home: TabsScreen(),
            onGenerateRoute: appRoute.onGenerateRoute,
          );
        },
      ),
    );
  }
}
