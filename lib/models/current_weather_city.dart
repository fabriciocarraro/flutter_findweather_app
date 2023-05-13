import 'package:flutter_weather_app_api/models/city.dart';

class CurrentWeatherCity {
  final City city;
  final double temperatureCelsius;
  final String conditionText;
  final String conditionIcon;
  final double windSpeedKph;
  final String windDirection;
  final int humidity;
  final double feelsLikeCelsius;
  final double precipitationMm;
  final int cloudCoverage;

  CurrentWeatherCity(
      {required this.city,
      required this.temperatureCelsius,
      required this.conditionText,
      required this.conditionIcon,
      required this.windSpeedKph,
      required this.windDirection,
      required this.humidity,
      required this.feelsLikeCelsius,
      required this.precipitationMm,
      required this.cloudCoverage});

  CurrentWeatherCity.fromMap(this.city, Map<String, dynamic> map)
      : temperatureCelsius = map["current"]["temp_c"],
        conditionText = map["current"]["condition"]["text"],
        conditionIcon = map["current"]["condition"]["icon"],
        windSpeedKph = map["current"]["wind_kph"],
        windDirection = map["current"]["wind_dir"],
        humidity = map["current"]["humidity"],
        feelsLikeCelsius = map["current"]["feelslike_c"],
        precipitationMm = map["current"]["precip_mm"],
        cloudCoverage = map["current"]["cloud"];
}
