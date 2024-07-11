import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import '/feature/data/services/rest_client.dart';
import '/feature/domain/entities/task_entity.dart';
import 'router/app_router.dart';
import '/router/app_route_inf_parser.dart';
import '/feature/presentation/bloc/task_provider.dart';
import '/constants/themes.dart';

class MyApp extends StatelessWidget {
  final Box<TaskEntity> taskBox;
  final RestClient client;
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate();
  final AppRouteInformationParser _appRouteInformationParser =
      AppRouteInformationParser();

  MyApp({super.key, required this.taskBox, required this.client});

  @override
  Widget build(BuildContext context) {
    return TaskProvider(
      taskBox: taskBox,
      client: client,
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
        locale: const Locale('ru'),
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
