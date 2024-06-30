import 'dart:convert';
import 'package:http/http.dart' as http;
import '/feature/data/models/todo_item.dart';

const String BASE_URL = "https://beta.mrdekk.ru/todo";
const String TOKEN = "YOUR_AUTH_TOKEN";

Future<List<TodoItem>> fetchTodoList() async {
  final response = await http.get(
    Uri.parse('$BASE_URL/list'),
    headers: {'Authorization': 'Bearer $TOKEN'},
  );
  if (response.statusCode == 200) {
    final jsonList = jsonDecode(response.body)['list'] as List;
    return jsonList.map((e) => TodoItem.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load todo list');
  }
}

Future<TodoItem> fetchTodoItem(String id) async {
  final response = await http.get(
    Uri.parse('$BASE_URL/list/$id'),
    headers: {'Authorization': 'Bearer $TOKEN'},
  );
  if (response.statusCode == 200) {
    return TodoItem.fromJson(jsonDecode(response.body)['element']);
  } else if (response.statusCode == 404) {
    throw Exception('Todo item not found');
  } else {
    throw Exception('Failed to load todo item');
  }
}

Future<void> updateTodoItem(TodoItem item) async {
  final response = await http.put(
    Uri.parse('$BASE_URL/list/${item.id}'),
    headers: {
      'Authorization': 'Bearer $TOKEN',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(item.toJson()),
  );
  if (response.statusCode == 404) {
    throw Exception('Todo item not found');
  } else if (response.statusCode == 400) {
    throw Exception('Revision mismatch');
  } else if (response.statusCode != 200) {
    throw Exception('Failed to update todo item');
  }
}

Future<void> deleteTodoItem(String id) async {
  final response = await http.delete(
    Uri.parse('$BASE_URL/list/$id'),
    headers: {'Authorization': 'Bearer $TOKEN'},
  );
  if (response.statusCode == 404) {
    throw Exception('Todo item not found');
  } else if (response.statusCode == 400) {
    throw Exception('Revision mismatch');
  } else if (response.statusCode != 200) {
    throw Exception('Failed to delete todo item');
  }
}
