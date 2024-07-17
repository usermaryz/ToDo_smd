import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/data/services/rest_client.dart';
import '/feature/data/services/sync_manager.dart';
import '/feature/data/services/dio_client.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(baseUrl, token);
});

final restClientProvider = Provider<RestClient>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return RestClient(dioClient);
});

final hiveBoxProvider = FutureProvider<Box<TaskEntity>>((ref) async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(TaskEntityAdapter());
  return Hive.openBox<TaskEntity>('tasks');
});

final syncManagerProvider = FutureProvider<SyncManager>((ref) async {
  final taskBox = await ref.read(hiveBoxProvider.future);
  final restClient = ref.read(restClientProvider);
  return SyncManager(taskBox: taskBox, restClient: restClient);
});
