import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/screens/main_page.dart';
import 'package:provider/provider.dart';
import 'models/current_weather_city_list.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CurrentWeatherCityList(currentWeatherCityList: []),
      child: const FindWeatherApp()));
}

class FindWeatherApp extends StatelessWidget {
  const FindWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindWeather',
      theme: ThemeData(
        fontFamily: 'Overpass',
        primaryColor: Colors.white,
      ),
      home: const MainPage(
        selectedIndex: 0,
      ),
    );
  }
}
