import 'package:http/http.dart' as http;

class HttpClient {
  final String baseUrl;
  final String token;

  HttpClient(this.baseUrl, this.token);

  Future<http.Response> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> post(String endpoint,
      {Map<String, String>? headers, Object? body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<http.Response> patch(String endpoint,
      {Map<String, String>? headers, Object? body}) async {
    final response = await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to patch data');
    }
  }

  Future<http.Response> put(String endpoint,
      {Map<String, String>? headers, Object? body}) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to put data');
    }
  }

  Future<http.Response> delete(String endpoint,
      {Map<String, String>? headers, Object? body}) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to delete data');
    }
  }
}
