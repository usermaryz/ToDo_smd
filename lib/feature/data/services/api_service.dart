/*
import 'dart:convert';
import 'package:http/http.dart' as http;

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

Future<TodoItem> fetchTodoItem(String id) async {
  final response = await http.get(Uri.parse('$BASE_URL/list/$id'));
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
    headers: {'Content-Type': 'application/json'},
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
  final response = await http.delete(Uri.parse('$BASE_URL/list/$id'));
  if (response.statusCode == 404) {
    throw Exception('Todo item not found');
  } else if (response.statusCode == 400) {
    throw Exception('Revision mismatch');
  } else if (response.statusCode != 200) {
    throw Exception('Failed to delete todo item');
  }
}

*/