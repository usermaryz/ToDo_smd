import 'package:flutter/material.dart';
import '/feature/presentation/pages/home.dart';
import '/feature/presentation/pages/new_task.dart';
import '/feature/domain/entities/task_entity.dart';
import 'app_routes.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutes>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutes> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRoutes? _currentRoute;
  TaskEntity? selectedTask;
  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  AppRoutes? get currentConfiguration => _currentRoute;

  void handleNavigation(AppRoutes route, {TaskEntity? task}) {
    _currentRoute = route;
    selectedTask = task;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (_currentRoute == null || _currentRoute == AppRoutes.home)
          const MaterialPage(child: Home()),
        if (_currentRoute == AppRoutes.newTask)
          if (selectedTask != null)
            MaterialPage(child: NewTask(task: selectedTask!))
          else
            const MaterialPage(child: NewTask()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _currentRoute = AppRoutes.home;
        selectedTask = null;
        notifyListeners();
        return true;
      },
      transitionDelegate: NoAnimationTransitionDelegate(),
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutes configuration) async {
    _currentRoute = configuration;
  }
}

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord>
        locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>>
        pageRouteToPagelessRoutes,
  }) {
    return newPageRouteHistory;
  }
}
