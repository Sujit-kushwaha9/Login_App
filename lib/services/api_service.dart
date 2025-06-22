
// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('https://api.escuelajs.co/api/v1/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {'error': jsonDecode(response.body)['message'].toString()};
      }
    } catch (e) {
      return {'error': 'Network error. Please try again.'};
    }
  }
}