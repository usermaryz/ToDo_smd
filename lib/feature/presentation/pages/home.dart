import 'package:flutter/material.dart';
import '/feature/presentation/widgets/todo_list.dart';
import '/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/feature/presentation/bloc/task_event.dart';
import '/feature/presentation/bloc/task_provider.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/presentation/bloc/task_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    analytics.setAnalyticsCollectionEnabled(true);

    scrollController.addListener(() {
      bool? newRenderButtonHeader;
      if (scrollController.offset > 80) {
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
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: FloatingActionButton(
            onPressed: () async {
              final routerDelegate =
                  Router.of(context).routerDelegate as AppRouterDelegate;
              routerDelegate.handleNavigation(AppRoutes.newTask);
              await analytics.logEvent(
                  name: 'open_page', parameters: {'page': 'new_task'});
            },
            shape: const CircleBorder(),
            backgroundColor: Theme.of(context).textTheme.labelLarge?.color,
            child: const Icon(Icons.add, color: tdWhite),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 100,
                toolbarHeight: 80,
                backgroundColor: Theme.of(context).primaryColor,
                onStretchTrigger: () async {},
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(top: 50, left: 50),
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Messages.appTitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
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
                        color: Theme.of(context).textTheme.labelLarge?.color,
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

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        bool isLargeScreen = constraints.maxWidth > 600;
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Text(
                                      '${Messages.completed} - $completedTasksCount',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 16,
                                          ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: _toggleShowCompletedTasks,
                                    icon: Icon(
                                      showCompletedTasks
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.color,
                                    ),
                                  ),
                                ],
                              ),
                              isLargeScreen
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: HomeBody(
                                              showCompletedTasks:
                                                  showCompletedTasks),
                                        ),
                                      ],
                                    )
                                  : HomeBody(
                                      showCompletedTasks: showCompletedTasks),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
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
        Container(height: 40),
        TodoList(showCompletedTasks: showCompletedTasks),
        const SizedBox(
          height: 40,
        ),
        TextButton(
          onPressed: () => throw Exception(),
          child: const Text("Throw Test Exception"),
        ),
      ],
    );
  }
}
