import 'package:flutter/material.dart';
import '/feature/presentation/widgets/todo_list.dart';
import '/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/feature/presentation/bloc/task_event.dart';
import '/feature/presentation/bloc/task_provider.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/presentation/bloc/task_bloc.dart';
import '/constants/strings.dart';
import '/router/app_routes.dart';
import '/router/app_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scrollController = ScrollController();
  bool renderButtonHeader = false;
  bool showCompletedTasks = false;

  @override
  void initState() {
    scrollController.addListener(() {
      bool? newRenderButtonHeader;
      if (scrollController.offset > 120) {
        newRenderButtonHeader = true;
      } else {
        newRenderButtonHeader = false;
      }
      if (newRenderButtonHeader != renderButtonHeader) {
        setState(() {
          renderButtonHeader = newRenderButtonHeader!;
        });
      }
    });
    super.initState();
  }

  void _toggleShowCompletedTasks() {
    setState(() {
      showCompletedTasks = !showCompletedTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskBloc = TaskProvider.of(context);
    taskBloc.add(LoadTasks());

    return Scaffold(
      backgroundColor: backPrimary,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final routerDelegate =
              Router.of(context).routerDelegate as AppRouterDelegate;
          routerDelegate.handleNavigation(AppRoutes.newTask);
        },
        shape: const CircleBorder(),
        backgroundColor: tdBlue,
        child: const Icon(Icons.add, color: tdWhite),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 80,
            backgroundColor: backPrimary,
            onStretchTrigger: () async {},
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(top: 50, left: 50),
              title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Messages.appTitle,
                  style: const TextStyle(
                    color: labPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            actions: [
              if (renderButtonHeader)
                IconButton(
                  onPressed: _toggleShowCompletedTasks,
                  icon: Icon(
                    showCompletedTasks
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
            ],
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<TaskBloc, List<TaskEntity>>(
              bloc: taskBloc,
              builder: (context, tasks) {
                final completedTasksCount =
                    tasks.where((task) => task.done).length;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Text(
                            '${Messages.completed} - $completedTasksCount',
                            style: const TextStyle(
                                color: labTernitary, fontSize: 16),
                          ),
                        ),
                        IconButton(
                          onPressed: _toggleShowCompletedTasks,
                          icon: Icon(
                            showCompletedTasks
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ],
                    ),
                    HomeBody(showCompletedTasks: showCompletedTasks),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  final bool showCompletedTasks;

  const HomeBody({super.key, required this.showCompletedTasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 20),
        TodoList(showCompletedTasks: showCompletedTasks),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

/*class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
*/