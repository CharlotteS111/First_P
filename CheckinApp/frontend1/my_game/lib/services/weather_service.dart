import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'b4de4ca15c9b411ebe9123953232207';

  Future<Map<String, dynamic>> getWeather() async {
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

    Position _locationData = await Geolocator.getCurrentPosition();

    final url = Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=${_locationData.latitude},${_locationData.longitude}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
