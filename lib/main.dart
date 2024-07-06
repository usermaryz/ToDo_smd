import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/data/services/rest_client.dart';
import '/my_app.dart';

void main() async {
  const String baseUrl = 'https://hive.mrdekk.ru/todo';
  const String token = 'Osse';
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(TaskEntityAdapter());
  final taskBox = await Hive.openBox<TaskEntity>('tasks');
  final RestClient client = RestClient(baseUrl, token);

  runApp(MyApp(taskBox: taskBox, client: client));
}
