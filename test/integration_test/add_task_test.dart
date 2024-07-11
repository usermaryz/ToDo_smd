import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_usermary/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Add Task Integration Test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Найдите и нажмите кнопку добавления задачи
    final addTaskButton = find.byIcon(Icons.add);
    await tester.tap(addTaskButton);
    await tester.pumpAndSettle();

    // Найдите текстовое поле для ввода задачи и введите текст
    final taskTextField = find.byType(TextField);
    await tester.enterText(taskTextField, 'New Integration Test Task');
    await tester.pumpAndSettle();

    // Найдите кнопку сохранения и нажмите её
    final saveButton = find.text('Save');
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Убедитесь, что новая задача отображается на экране
    expect(find.text('New Integration Test Task'), findsOneWidget);
  });
}
