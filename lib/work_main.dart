import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController cityController = TextEditingController();
  String cityName = "";
  String weatherDescription = "";
  String temperature = "";
  String windSpeed = "";
  final tempText = "Температура ";

  void getWeatherData() async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=58cb8de68ece7acf0c4e762a28d458ac&units=metric&lang=ru";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);

      setState(() {
        weatherDescription =
            decodedJson["weather"][0]["description"].toString().toUpperCase();
        temperature = tempText + decodedJson["main"]["temp"].toString();
        windSpeed = "Скорость ветра " + decodedJson["wind"]["speed"].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 100,
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Введите название города",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      cityController.clear();
                    },
                  ),
                ),
                controller: cityController,
                keyboardType: TextInputType.text,
                onSubmitted: (value) {
                  if(value.isNotEmpty && value.contains(new RegExp(r'^[a-zA-Z]+$'))) {
                    cityName = value;
                    getWeatherData();
                  } else {
                    print('Invalid input');
                  }
                },
              ),
            ),
          ),
          Container(
            height: 120,
            width: 350,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                buildSizedBox(),
                Text(
                  "$weatherDescription",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                buildSizedBox(),
                Text(
                  temperature,
                  style: TextStyle(
                    color:
                    temperature.contains("-") ? Colors.blue : Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                buildSizedBox(),
                Text(
                  "$windSpeed",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 11,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WeatherScreen(),
  ));

}
