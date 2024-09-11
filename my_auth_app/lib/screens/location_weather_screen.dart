import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationWeatherScreen extends StatefulWidget {
  final String userName;

  LocationWeatherScreen({required this.userName});

  @override
  _LocationWeatherScreenState createState() => _LocationWeatherScreenState();
}

class _LocationWeatherScreenState extends State<LocationWeatherScreen> {
  LatLng? _currentPosition;
  String? _weather;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLocationAndWeather();
  }

  Future<void> _getLocationAndWeather() async {
    try {
      Position position = await _determinePosition();
      _currentPosition = LatLng(position.latitude, position.longitude);
      String weather = await _fetchWeather(position.latitude, position.longitude);

      setState(() {
        _weather = weather;
        _isLoading = false;
      });

      await _saveUserHistory(_currentPosition!, _weather!);

    } catch (e) {
      setState(() {
        _weather = 'Failed to get weather';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveUserHistory(LatLng location, String weather) async {
    final url = 'http://127.0.0.1:8080/user-history/add';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': widget.userName,
        'location': 'Lat: ${location.latitude}, Lon: ${location.longitude}',
        'weather': weather,
        'time': DateTime.now().toString(),
      }),
    );

    if (response.statusCode == 200) {
      print('History saved successfully');
    } else {
      print('Failed to save history');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> _fetchWeather(double latitude, double longitude) async {
    final apiKey = 'b4de4ca15c9b411ebe9123953232207';
    final url = 'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$latitude,$longitude';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);
      final description = weatherData['current']['condition']['text'];
      final temp = weatherData['current']['temp_c'];
      return 'Temp: $temp°C, Condition: $description';
    } else {
      return 'Failed to get weather data';
    }
  }

  Future<List<dynamic>> _fetchUserHistory() async {
    final url = 'http://127.0.0.1:8080/user-history/find/${widget.userName}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load history');
    }
  }

  void _showHistory() async {
    try {
      final history = await _fetchUserHistory();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("User History"),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: history.length,
                itemBuilder: (BuildContext context, int index) {
                  final historyItem = history[index];
                  final time = historyItem['time'] ?? 'Unknown time';
                  final location = historyItem['location'] ?? 'Unknown location';
                  final weather = historyItem['weather'] ?? 'Unknown weather';

                  return ListTile(
                    title: Text(time),
                    subtitle: Text('Location: $location\nWeather: $weather'),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          );
        },
      );

    } catch (e) {
      print('Failed to fetch user history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location & Weather')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Time: ${DateTime.now()}'),
          ),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: _currentPosition ?? LatLng(0, 0),
                zoom: 14.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                if (_currentPosition != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _currentPosition!,
                        builder: (ctx) => Container(
                          child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Weather: $_weather'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              _getLocationAndWeather();
            },
            child: Text('Refresh Weather'),
          ),
          ElevatedButton(
            onPressed: _showHistory,
            child: Text('Show History'),
          ),
        ],
      ),
    );
  }
}
