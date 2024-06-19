import 'package:flutter/material.dart';
import '/feature/presentation/widgets/todo_list.dart';
import '/constants/colors.dart';
import '/feature/presentation/pages/newTask.dart';
import '/feature/presentation/bloc/task_event.dart';
import '/feature/presentation/bloc/task_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskBloc = TaskProvider.of(context);
    taskBloc.add(LoadTasks());

    return Scaffold(
      backgroundColor: backPrimary,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTask(),
            ),
          );
        },
        shape: CircleBorder(),
        backgroundColor: tdBlue,
        child: const Icon(Icons.add, color: tdWhite),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 70.0,
            backgroundColor: backPrimary,
            flexibleSpace: const FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(top: 70, left: 50),
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Мои дела",
                    style: TextStyle(
                        color: labPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                  ),
                )),
          ),
          SliverToBoxAdapter(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    "Выполнено - ФФФФ",
                    style: TextStyle(color: labTernitary, fontSize: 16),
                  ),
                ),
                HomeBody(),
              ])),
        ],
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 20),
        TodoList(),
        SizedBox(
          height: 40,
        )
      ],
    );
  }
}
