// lib/services/todo_service.dart
/*import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_item.dart';

const String BASE_URL = "https://beta.mrdekk.ru/todo";

Future<List<TodoItem>> fetchTodoList() async {
  final response = await http.get(Uri.parse('$BASE_URL/list'));
  if (response.statusCode == 200) {
    final jsonList = jsonDecode(response.body)['list'] as List;
    return jsonList.map((e) => TodoItem.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load todo list');
  }
}
*/

// TODO: fetchTodoItem, updateTodoItem, deleteTodoItem
