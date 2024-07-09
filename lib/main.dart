import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/data/services/rest_client.dart';
import '/my_app.dart';
import '/feature/presentation/pages/no_internet_page.dart';
import '/feature/data/services/sync_manager.dart';
import '/feature/data/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String baseUrl = 'https://hive.mrdekk.ru/todo';
  const String token = 'Osse';

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(TaskEntityAdapter());
  final taskBox = await Hive.openBox<TaskEntity>('tasks');
  final RestClient client = RestClient(baseUrl, token);

  //final syncManager = SyncManager(taskBox: taskBox, restClient: client);
  //await syncManager.syncTasks();

  final connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    runApp(NoInternetApp());
  } else {
    runApp(MyApp(taskBox: taskBox, client: client));
  }
}
