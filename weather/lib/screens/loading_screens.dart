import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:weather/screens/main_screen.dart';
import 'package:weather/utils/location_helper.dart';
import 'package:weather/utils/weatherdata.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData; // izinler kısmı ve atama kısmı
  Future<void> getLocationData() async {
    locationData = LocationHelper(); // bi nesne oluşturdun
    await locationData.getCurrentLocation(); // verileri getirmesini bekliyorsun

    if (locationData.latitude == null || locationData.longitude == null) {
      print("Konum Bilgileri Gelemiyor");
    } else {
      print('latitude: ${locationData.latitude}');
      print('longitude: ${locationData.longitude}');
    }
  }

  void getWeatherData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentConiditon == null) {
      print("Api boş dönüyor");
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(weatherData: weatherData,);
    }));
  }

  @override
  void initState() {
    super.initState();
    getWeatherData(); // program açılır açılmaz bu çalışsın istiyoruz çünkü bu bilgiye göre veriler egetirilicek o yüzden initstate içine yazdık bu fonksiyonu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // arka plan rengini verdik
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.pink.shade300, Colors.yellow.shade300]),
        ),
        child: const Center(
          child: SpinKitHourGlass(
            // bekleme animasyonu ekleme yeri (flutter_spinkit kütüphanesi)
            color: Colors.white60,
            size: 150.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
