import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_usermary/main.dart' as app;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Инициализация Hive для тестирования
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('tasks');

  testWidgets('Add Task Integration Test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Найти кнопку добавления задачи и нажать ее
    final addTaskButton = find.byIcon(Icons.add);
    await tester.tap(addTaskButton);
    await tester.pumpAndSettle();

    // Найти текстовое поле для ввода задачи и ввести текст
    final taskTextField = find.byType(TextField);
    await tester.enterText(taskTextField, 'New Integration Test Task');
    await tester.pumpAndSettle();

    // Найти кнопку сохранения и нажать ее
    final saveButton = find.text('Save');
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Проверить, что задача добавлена и отображается на экране
    expect(find.text('New Integration Test Task'), findsOneWidget);

    // Проверить, что задача добавлена в Hive
    final tasksBox = Hive.box('tasks');
    final tasks = tasksBox.values.toList();
    expect(
        tasks.any((task) => task.text == 'New Integration Test Task'), isTrue);
  });
}
