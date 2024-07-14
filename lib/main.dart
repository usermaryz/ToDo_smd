import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '/my_app.dart';
import '/feature/presentation/pages/no_internet_page.dart';
import '/feature/domain/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

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

  await Firebase.initializeApp();

  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 5),
    minimumFetchInterval: const Duration(seconds: 1),
  ));

  await remoteConfig.fetchAndActivate();

  final connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    return const NoInternetApp();
  } else {
    final taskBox = await container.read(hiveBoxProvider.future);
    final restClient = container.read(restClientProvider);

    await remoteConfig.setDefaults(const {"importanceColor": '#FF3B30'});

    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    await analytics.logEvent(
      name: 'app_started',
      parameters: {'connectivity': connectivityResult.toString()},
    );

    return MyApp(taskBox: taskBox, client: restClient);
  }
}
