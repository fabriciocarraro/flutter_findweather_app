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
  final double temperature9AM;
  final String icon9AM;
  final double temperature1PM;
  final String icon1PM;
  final double temperature5PM;
  final String icon5PM;
  final double temperature11PM;
  final String icon11PM;

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
      required this.cloudCoverage,
      required this.temperature9AM,
      required this.icon9AM,
      required this.temperature1PM,
      required this.icon1PM,
      required this.temperature5PM,
      required this.icon5PM,
      required this.temperature11PM,
      required this.icon11PM});

  CurrentWeatherCity.fromMap(this.city, Map<String, dynamic> map)
      : temperatureCelsius = map["current"]["temp_c"],
        conditionText = map["current"]["condition"]["text"],
        conditionIcon = map["current"]["condition"]["icon"],
        windSpeedKph = map["current"]["wind_kph"],
        windDirection = map["current"]["wind_dir"],
        humidity = map["current"]["humidity"],
        feelsLikeCelsius = map["current"]["feelslike_c"],
        precipitationMm = map["current"]["precip_mm"],
        cloudCoverage = map["current"]["cloud"],
        temperature9AM = map["forecast"]["forecastday"][0]["hour"][9]["temp_c"],
        icon9AM =
            map["forecast"]["forecastday"][0]["hour"][9]["condition"]["icon"],
        temperature1PM =
            map["forecast"]["forecastday"][0]["hour"][13]["temp_c"],
        icon1PM =
            map["forecast"]["forecastday"][0]["hour"][13]["condition"]["icon"],
        temperature5PM =
            map["forecast"]["forecastday"][0]["hour"][17]["temp_c"],
        icon5PM =
            map["forecast"]["forecastday"][0]["hour"][17]["condition"]["icon"],
        temperature11PM =
            map["forecast"]["forecastday"][0]["hour"][23]["temp_c"],
        icon11PM =
            map["forecast"]["forecastday"][0]["hour"][23]["condition"]["icon"];
}
