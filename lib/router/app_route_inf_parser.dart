import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutes> {
  @override
  Future<AppRoutes> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return AppRoutes.home;
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'new-task') {
        return AppRoutes.newTask;
      }
    }

    return AppRoutes.home;
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutes configuration) {
    switch (configuration) {
      case AppRoutes.home:
        return RouteInformation(uri: Uri.parse('/'));
      case AppRoutes.newTask:
        return RouteInformation(uri: Uri.parse('/new-task'));
    }
  }
}
