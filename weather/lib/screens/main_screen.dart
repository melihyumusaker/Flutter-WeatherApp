import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/utils/weatherdata.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;

  MainScreen({required this.weatherData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late double temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String city;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      city = weatherData.city;
      temperature = weatherData.currentTemperature;
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: backgroundImage, fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(child: weatherDisplayIcon),
            const SizedBox(height: 15),
            Center(
              child: Text(
                '${temperature} C',
                style: const TextStyle(
                    color: Colors.white, fontSize: 80, letterSpacing: -3),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                '${city}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 50,
                  letterSpacing: -3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
