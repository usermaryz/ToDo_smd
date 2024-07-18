import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '/my_app.dart';
import '/feature/presentation/pages/no_internet_page.dart';
import '/feature/domain/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: await initializeApp(),
    ),
  );
}

Future<Widget> initializeApp() async {
  final container = ProviderContainer();
  final syncManager = await container.read(syncManagerProvider.future);
  await syncManager.syncTasks();

  final connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    return const NoInternetApp();
  } else {
    final taskBox = await container.read(hiveBoxProvider.future);
    final restClient = container.read(restClientProvider);
    return MyApp(taskBox: taskBox, client: restClient);
  }
}