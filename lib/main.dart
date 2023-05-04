import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/screens/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      theme: ThemeData(
        fontFamily: 'Overpass',
        primaryColor: Colors.white,
      ),
      home: const WelcomePage(),
    );
  }
}
