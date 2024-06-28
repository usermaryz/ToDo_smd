import 'package:flutter/material.dart';
import '/feature/domain/entities/task_entity.dart';
import '/feature/presentation/bloc/task_event.dart';
import '/feature/presentation/bloc/task_provider.dart';
import '/feature/presentation/bloc/task_bloc.dart';
import '/feature/presentation/widgets/date_time.dart';
import '/constants/colors.dart';
import '/utils/logger.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  late TextEditingController _taskController;
  int _importance = 2;
  DateTime? selectedDate;
  bool switchValue = false;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
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
        actions: [
          TextButton(
            child: const Text('СОХРАНИТЬ', style: TextStyle(color: tdBlue)),
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
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    fillColor: tdWhite,
                    filled: true,
                    hintStyle: TextStyle(color: labTernitary),
                    hintText: 'Что надо сделать...',
                    border: InputBorder.none, // Remove the border
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
              const Text(
                'Приоритет',
                style: TextStyle(
                  fontSize: 16,
                  decorationColor: labTernitary,
                  color: labPrimary,
                ),
              ),
              DropdownButton<int>(
                value: _importance,
                onChanged: (int? value) {
                  setState(() {
                    _importance = value!;
                  });
                  AppLogger.d('Importance set to $_importance');
                },
                items: const [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('Высокий',
                        style: TextStyle(
                          color: labPrimary,
                          fontSize: 14,
                        )),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('Средний',
                        style: TextStyle(
                          color: labPrimary,
                          fontSize: 14,
                        )),
                  ),
                  DropdownMenuItem<int>(
                    value: 3,
                    child: Text('Низкий',
                        style: TextStyle(
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
                  const Text(
                    'Выбрать дату',
                    style: TextStyle(
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
                  titleText: 'Сделать до',
                  valueText: selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : 'дд/мм/гг',
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
              const Row(children: [
                Icon(Icons.delete, color: labTernitary),
                SizedBox(
                  width: 10,
                ),
                Text('Удалить',
                    style: TextStyle(
                      fontSize: 16,
                      color: labTernitary,
                    ))
              ])
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
      id: DateTime.now().millisecondsSinceEpoch,
      description: _taskController.text,
      importance: _importance,
      isDone: false,
      date: selectedDate,
    );

    taskBloc.add(AddTask(newTask));
    AppLogger.i('New task added: $newTask');
    Navigator.of(context).pop();
  }
}
