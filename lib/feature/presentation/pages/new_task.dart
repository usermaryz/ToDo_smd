import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/presentation/bloc/task_event.dart';
import '/feature/presentation/bloc/task_provider.dart';
import '/feature/presentation/bloc/task_bloc.dart';
import '/feature/presentation/widgets/date_time.dart';
import '/constants/colors.dart';
import '/utils/logger.dart';
import '/constants/strings.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
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
            child: Text(
              Messages.saveButton,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(),
            ),
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      filled: true,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 16),
                      hintText: Messages.newTaskHint,
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 16)),
              ),
              const SizedBox(height: 20),
              Divider(
                color: Theme.of(context).inputDecorationTheme.hintStyle?.color,
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              const SizedBox(height: 20),
              Text(Messages.priority,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 16, decorationColor: labTernitary)),
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
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 14, color: tdRed)),
                  ),
                  DropdownMenuItem<String>(
                    value: 'basic',
                    child: Text(Messages.medium,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 14)),
                  ),
                  DropdownMenuItem<String>(
                    value: 'low',
                    child: Text(Messages.low,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Divider(
                color: Theme.of(context).inputDecorationTheme.hintStyle?.color,
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Switch(
                    activeColor: Theme.of(context).textTheme.labelLarge?.color,
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
              Divider(
                color: Theme.of(context).inputDecorationTheme.hintStyle?.color,
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
                    Icon(
                      Icons.delete,
                      color: deleteButton
                          ? Theme.of(context).textTheme.labelMedium?.color
                          : Theme.of(context).textTheme.bodySmall?.color,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(Messages.delete,
                        style: TextStyle(
                          fontSize: 16,
                          color: deleteButton
                              ? Theme.of(context).textTheme.labelMedium?.color
                              : Theme.of(context).textTheme.bodySmall?.color,
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
      id: widget.task?.id ?? const Uuid().v4(),
      text: _taskController.text,
      importance: _importance,
      done: widget.task?.done ?? false,
      deadline: selectedDate,
      createdAt: widget.task?.createdAt ?? DateTime.now(),
      changedAt: DateTime.now(),
      lastUpdatedBy: '123',
    );

    if (widget.task != null) {
      taskBloc.add(UpdateTask(newTask));
      AppLogger.i('Task updated: $newTask');
    } else {
      taskBloc.add(AddTask(newTask));
      AppLogger.i('New task added: $newTask');
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      Navigator.of(context).pop();
    });
  }

  void _deleteTask(TaskBloc taskBloc) {
    taskBloc.add(DeleteTask(id!));
    Future.delayed(const Duration(milliseconds: 100), () {
      Navigator.of(context).pop();
    });
  }
}
