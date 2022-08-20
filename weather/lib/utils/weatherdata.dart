import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'location_helper.dart';

final apiKey = "10410543d746d4f2d300aeb44e5e70ec";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;
  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData});
  late LocationHelper locationData;
  late double currentTemperature;
  late int currentConiditon;
  late String city;

  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric",
    ));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentConiditon = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
      } catch (e) {
        print(e);
      }
    } else {
      print("API'den değer gelmiyor");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentConiditon < 600) {
      return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
            size: 75.0,
            color: Colors.white,
          ),
          weatherImage: AssetImage('assets/bulutlu.png'));
    } else {
      //hava iyi
      //gece gündüz kontrolü
      var now = new DateTime.now();
      if (now.hour >= 19) {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/gece.png'));
      } else {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/gunesli.png'));
      }
    }
  }
}
