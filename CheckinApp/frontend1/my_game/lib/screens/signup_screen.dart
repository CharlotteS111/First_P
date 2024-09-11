import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/auth_service.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Create Account", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(
                controller: userNameController,
                decoration: InputDecoration(labelText: "UserName", border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder()),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(labelText: "Confirm Password", border: OutlineInputBorder()),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String userName = userNameController.text;
                  String password = passwordController.text;
                  String confirmPassword = confirmPasswordController.text;

                  if (password == confirmPassword) {
                    AuthService authService = AuthService();
                    await authService.signUp(userName, password);
                  } else {
                    Fluttertoast.showToast(msg: "Passwords do not match");
                  }
                },
                child: Text("Sign Up"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
