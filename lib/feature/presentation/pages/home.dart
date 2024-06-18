import 'package:flutter/material.dart';
import '/feature/presentation/widgets/todo_list.dart';
import '/constants/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backPrimary,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: создание новой задачи
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
            expandedHeight: 60.0,
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
            child: HomeBody(),
          ),
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
        Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              // TODO: счетчик сделанных дел
              "Выполнено - ФФФФ",
              style: TextStyle(color: labTernitary, fontSize: 15),
            )),
        Container(height: 20),
        TodoList(),
        SizedBox(
          height: 40,
        )
      ],
    );
  }
}
