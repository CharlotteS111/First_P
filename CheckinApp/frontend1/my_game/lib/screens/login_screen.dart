import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'game_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome Back!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
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
              ElevatedButton(
                onPressed: () async {
                  String userName = userNameController.text;
                  String password = passwordController.text;

                  AuthService authService = AuthService();
                  await authService.login(userName, password);

                  // Fetch the random number after login
                  int randomNumber = await authService.fetchRandomNumber();

                  // Navigate to the game screen and pass the random number
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(randomNumber: randomNumber),
                    ),
                  );
                },
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
