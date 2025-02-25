import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/strings.dart';

class CustomAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final int completedTasks;

  CustomAppBar({required this.expandedHeight, required this.completedTasks});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    double t = 1.0;
    if (settings != null) {
      t = (1.0 - (settings.currentExtent - minExtent) / (maxExtent - minExtent))
          .clamp(0.0, 1.0);
    }

    bool isAppBarExpanded = t < 0.5;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Container(
          color: backPrimary,
          child: FlexibleSpaceBar(
            titlePadding:
                EdgeInsets.only(left: isAppBarExpanded ? 50 : 16, bottom: 16),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    Messages.appTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                  Expanded(child: Container()),
                  if (!isAppBarExpanded)
                    const Icon(Icons.visibility, color: Colors.black),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 50,
          bottom: 10,
          child: Opacity(
            opacity: isAppBarExpanded ? 1.0 : 0.0,
            child: Text(
              '${Messages.completed} - $completedTasks',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ),
        if (isAppBarExpanded)
          const Positioned(
            right: 16,
            bottom: 10,
            child: Icon(Icons.visibility, color: Colors.black),
          ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
