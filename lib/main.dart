import 'package:flutter/material.dart';
import 'feature/presentation/pages/home.dart';
import '/feature/presentation/bloc/task_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskProvider(
      child: const MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'EN'),
          const Locale('ru', 'RU'),
        ],
        locale: const Locale('ru'),
        title: 'ToDo App',
        home: Home(),
      ),
    );
  }
}
