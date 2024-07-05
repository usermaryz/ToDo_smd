import 'package:flutter/material.dart';
import '/feature/presentation/bloc/task_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '/feature/domain/entities/task_entity.dart';
import '/constants/colors.dart';
import 'router/app_router.dart';
import '/router/app_route_inf_parser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(TaskEntityAdapter());
  final taskBox = await Hive.openBox<TaskEntity>('tasks');

  runApp(MyApp(taskBox: taskBox));
}

class MyApp extends StatelessWidget {
  final Box<TaskEntity> taskBox;
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate();
  final AppRouteInformationParser _appRouteInformationParser =
      AppRouteInformationParser();

  MyApp({super.key, required this.taskBox});
  @override
  Widget build(BuildContext context) {
    return TaskProvider(
      taskBox: taskBox,
      child: MaterialApp.router(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'EN'),
          Locale('ru', 'RU'),
        ],
        locale: const Locale('en'),
        title: 'ToDo App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        routerDelegate: _appRouterDelegate,
        routeInformationParser: _appRouteInformationParser,
      ),
    );
  }
}
