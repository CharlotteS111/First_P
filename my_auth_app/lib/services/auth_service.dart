import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class AuthService {
  final String baseUrl = 'http://127.0.0.1:8080/user';

  Future<bool> signUp(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 && response.body == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 && response.body == 'true') {
      return true;
    } else {
      return false;
    }
  }
}
