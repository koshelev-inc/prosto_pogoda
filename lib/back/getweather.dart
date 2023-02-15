import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pogoda_app_new/back/peremen.dart';
import 'package:pogoda_app_new/front/front.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
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
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeatherDataUsingLocation() async {
    Position position = await _determinePosition();

    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=58cb8de68ece7acf0c4e762a28d458ac&units=metric&lang=ru";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);

      setState(() {
        weatherDescription =
            decodedJson["weather"][0]["description"].toString().toUpperCase();
        temperature = decodedJson["main"]["temp"].round().toString();
        windSpeed = decodedJson["wind"]["speed"].round().toString();
        locationMap = decodedJson["name"].toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getWeatherDataUsingLocation();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => getWeatherDataUsingLocation(),
        child: frontView(),
      ),
    );
  }
}
