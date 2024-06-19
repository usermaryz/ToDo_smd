import 'package:flutter/material.dart';
import 'feature/presentation/pages/home.dart';

import 'package:flutter/material.dart';
import '/feature/presentation/pages/home.dart';
import '/feature/presentation/bloc/task_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TaskProvider(
      child: MaterialApp(
        title: 'ToDo App',
        home: Home(),
      ),
    );
  }
}
