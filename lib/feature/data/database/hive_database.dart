/*import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/feature/data/models/todo_model.dart';

class HiveDatabase {
  static const String todoBoxName = "todos";
  static const String metadataBoxName = "metadata";
  static Box<TodoModel>? _todoBox;
  static Box? _metadataBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoModelAdapter());

    _todoBox = await Hive.openBox<TodoModel>(todoBoxName);
    _metadataBox = await Hive.openBox(metadataBoxName);
  }

  static Box<TodoModel> get todoBox {
    if (_todoBox == null) {
      throw Exception("HiveDatabase is not initialized yet.");
    }
    return _todoBox!;
  }

  static Box get metadataBox {
    if (_metadataBox == null) {
      throw Exception("HiveDatabase is not initialized yet.");
    }
    return _metadataBox!;
  }

  static Future<void> clearTodos() async {
    await todoBox.clear();
  }

  static Future<void> insertTodoModel(TodoModel todo) async {
    await todoBox.put(todo.id, todo);
  }

  static List<TodoModel> getTodos() {
    return todoBox.values.toList();
  }

  static Future<void> updateTodoModel(TodoModel todo) async {
    await todoBox.put(todo.id, todo);
  }

  static Future<void> deleteTodoModel(String id) async {
    await todoBox.delete(id);
  }

  static int getRevision() {
    return metadataBox.get('revision', defaultValue: 0);
  }

  static Future<void> setRevision(int revision) async {
    await metadataBox.put('revision', revision);
  }

  static Future<void> updateDatabase(Map<String, dynamic> data) async {
    if (!data.containsKey('list') || !data.containsKey('revision')) {
      throw ArgumentError('Invalid data format');
    }

    final List<dynamic> list = data['list'];
    final int revision = data['revision'];

    // Clear the current todos
    await clearTodos();

    // Insert the new todos
    for (var item in list) {
      final todo = TodoModel.fromJson(item);
      await insertTodoModel(todo);
    }

    // Update the revision
    await setRevision(revision);
  }
}
*/