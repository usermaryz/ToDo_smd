import 'package:flutter/material.dart';
import '/feature/presentation/pages/home.dart';
import '/feature/presentation/pages/new_task.dart';
import '/feature/domain/entities/task_entity.dart';
import 'app_routes.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutes>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutes> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppRoutes _currentRoute = AppRoutes.home;
  TaskEntity? selectedTask;

  @override
  AppRoutes get currentConfiguration => _currentRoute;

  void handleNavigation(AppRoutes route, {TaskEntity? task}) {
    _currentRoute = route;
    selectedTask = task;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    List<Page> pages = [
      const MaterialPage(
        key: ValueKey(AppRoutes.home),
        child: Home(),
      ),
    ];

    if (_currentRoute == AppRoutes.newTask) {
      pages.add(MaterialPage(
        key: const ValueKey(AppRoutes.newTask),
        child: NewTask(task: selectedTask),
      ));
    }

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        handleNavigation(AppRoutes.home);
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutes configuration) async {
    _currentRoute = configuration;
  }
}
