import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  static const String baseUrl = "http://127.0.0.1:8080/user";

  Future<void> login(String userName, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      body: json.encode({'userName': userName, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Handle success
      Fluttertoast.showToast(msg: "Login Successful");
    } else {
      // Handle error
      Fluttertoast.showToast(msg: "Login Failed");
    }
  }

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse('$baseUrl/signup');
    final response = await http.post(
      url,
      body: json.encode({'userName': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Handle success
      Fluttertoast.showToast(msg: "Sign Up Successful");
    } else {
      // Handle error
      Fluttertoast.showToast(msg: "Sign Up Failed");
    }
  }


  Future<int> fetchRandomNumber() async {
    final url = Uri.parse('$baseUrl/random_number');
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception("Failed to fetch random number");
    }
  }

}
