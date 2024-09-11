import 'package:flutter/material.dart';
import '../services/weather_service.dart'; // Import the weather service

class GameScreen extends StatefulWidget {
  final int randomNumber;

  GameScreen({required this.randomNumber});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int attemptsLeft = 3;
  String message = '';
  List<bool> selectedBoxes =
      List.generate(9, (index) => false); // Track selected state of each box
  String? location;
  String? temperature;
  String? condition;

  void _checkAnswer(int index) {
    if (selectedBoxes[index])
      return; // If the box is already selected, do nothing

    setState(() {
      selectedBoxes[index] = true;

      if (index + 1 == widget.randomNumber) {
        message = 'Congratulations! You selected the correct number.';
      } else {
        attemptsLeft--;
        if (attemptsLeft == 0) {
          message =
              'Sorry! No attempts left. The correct number was ${widget.randomNumber}.';
        } else {
          message = 'Wrong selection! Try again. Attempts left: $attemptsLeft';
        }
      }
    });
  }

  void _resetGame() {
    setState(() {
      attemptsLeft = 3;
      message = '';
      selectedBoxes = List.generate(9, (index) => false);
      location = null;
      temperature = null;
      condition = null;
    });
  }

  Future<void> _showLocationAndWeather() async {
    try {
      WeatherService weatherService = WeatherService();
      var weatherData = await weatherService.getWeather();

      setState(() {
        location = weatherData['location']['name'];
        temperature = "${weatherData['current']['temp_c']}°C";
        condition = weatherData['current']['condition']['text'];
      });
    } catch (e) {
      setState(() {
        location = "Error fetching location";
        temperature = "";
        condition = "$e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select the Correct Number")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: selectedBoxes[index] ||
                            attemptsLeft == 0 ||
                            message.contains('Congratulations!')
                        ? null
                        : () => _checkAnswer(index),
                    child: Text('${index + 1}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedBoxes[index]
                          ? Colors.grey
                          : Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showLocationAndWeather,
                child: Text("Show Location & Weather"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
              if (location != null && temperature != null && condition != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Text("Location: $location",
                          style: TextStyle(fontSize: 18)),
                      Text("Temperature: $temperature",
                          style: TextStyle(fontSize: 18)),
                      Text("Condition: $condition",
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              if (attemptsLeft == 0 || message.contains('Congratulations!'))
                Column(
                  children: [
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _resetGame,
                      child: Text("Retry"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
