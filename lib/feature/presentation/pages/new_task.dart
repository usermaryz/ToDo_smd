import 'package:flutter/material.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/presentation/bloc/task_event.dart';
import '/feature/presentation/bloc/task_provider.dart';
import '/feature/presentation/bloc/task_bloc.dart';
import '/feature/presentation/widgets/date_time.dart';
import '/constants/colors.dart';
import '/utils/logger.dart';
import '/constants/strings.dart';
import 'dart:io';

import '/router/app_routes.dart';
import '/router/app_router.dart';

class NewTask extends StatefulWidget {
  final TaskEntity? task;

  const NewTask({super.key, this.task});

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  late TextEditingController _taskController;
  String _importance = 'basic';
  String? id;
  DateTime? selectedDate;
  DateTime? createdAt;
  DateTime? changedAt;
  bool switchValue = false;
  bool deleteButton = false;
  int? revision;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _taskController = TextEditingController(text: widget.task!.text);
      id = widget.task!.id;
      _importance = widget.task!.importance;
      selectedDate = widget.task!.deadline;
      createdAt = widget.task!.createdAt;
      switchValue = widget.task!.deadline != null;
      deleteButton = true;
    } else {
      _taskController = TextEditingController();
      createdAt = DateTime.now();
    }

    AppLogger.d('NewTask screen initialized');
  }

  @override
  void dispose() {
    _taskController.dispose();
    AppLogger.d('NewTask screen disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskBloc = TaskProvider.of(context);

    return Scaffold(
      backgroundColor: backPrimary,
      appBar: AppBar(
        backgroundColor: backPrimary,
        leading: IconButton(
          onPressed: () {
            final routerDelegate =
                Router.of(context).routerDelegate as AppRouterDelegate;
            routerDelegate.handleNavigation(AppRoutes.home);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          TextButton(
            child: Text(Messages.saveButton,
                style: const TextStyle(color: tdBlue)),
            onPressed: () {
              _saveTask(taskBloc);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 2.0,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                shadowColor: Colors.grey.withOpacity(0.2),
                child: TextField(
                  controller: _taskController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    fillColor: tdWhite,
                    filled: true,
                    hintStyle: const TextStyle(color: labTernitary),
                    hintText: Messages.newTaskHint,
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                color: labTernitary,
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              const SizedBox(height: 20),
              Text(
                Messages.priority,
                style: const TextStyle(
                  fontSize: 16,
                  decorationColor: labTernitary,
                  color: labPrimary,
                ),
              ),
              DropdownButton<String>(
                value: _importance,
                onChanged: (String? value) {
                  setState(() {
                    _importance = value!;
                  });
                  AppLogger.d('Importance set to $_importance');
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'important',
                    child: Text(Messages.high,
                        style: const TextStyle(
                          color: labPrimary,
                          fontSize: 14,
                        )),
                  ),
                  DropdownMenuItem<String>(
                    value: 'basic',
                    child: Text(Messages.medium,
                        style: const TextStyle(
                          color: labPrimary,
                          fontSize: 14,
                        )),
                  ),
                  DropdownMenuItem<String>(
                    value: 'low',
                    child: Text(Messages.low,
                        style: const TextStyle(
                          color: labPrimary,
                          fontSize: 14,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                color: labTernitary,
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Messages.selectDate,
                    style: const TextStyle(
                      fontSize: 16,
                      color: labPrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Switch(
                    activeColor: tdBlue,
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                      AppLogger.d('Switch value changed to $switchValue');
                    },
                  ),
                ],
              ),
              if (switchValue)
                DateTimeWidget(
                  titleText: Messages.selectDate,
                  valueText: selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : Messages.ddmmyy,
                  iconSection: Icons.calendar_today,
                  onTap: (DateTime date) {
                    setState(() {
                      selectedDate = date;
                    });
                    AppLogger.d('Selected date set to $selectedDate');
                  },
                ),
              const SizedBox(height: 20),
              const Divider(
                color: labTernitary,
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              const SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    _deleteTask(taskBloc);
                  },
                  child: Row(children: [
                    Icon(Icons.delete,
                        color: deleteButton ? tdRed : labTernitary),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(Messages.delete,
                        style: TextStyle(
                          fontSize: 16,
                          color: deleteButton ? tdRed : labTernitary,
                        ))
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  void _saveTask(TaskBloc taskBloc) {
    if (_taskController.text.isEmpty) {
      AppLogger.w('Task description is empty');
      return;
    }

    final newTask = TaskEntity(
      id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      text: _taskController.text,
      importance: _importance,
      done: widget.task?.done ?? false,
      deadline: selectedDate,
      createdAt: widget.task?.createdAt ?? DateTime.now(),
      changedAt: DateTime.now(),
      lastUpdatedBy: '123',
    );

    if (widget.task != null) {
      taskBloc.add(UpdateTask(newTask, revision ?? 10));
      AppLogger.i('Task updated: $newTask');
    } else {
      taskBloc.add(AddTask(newTask, revision ?? 10));
      AppLogger.i('New task added: $newTask');
    }
    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.of(context).pop();
    });
  }

  void _deleteTask(TaskBloc taskBloc) {
    taskBloc.add(DeleteTask(id!, revision ?? 10));
    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.of(context).pop();
    });
  }
}
