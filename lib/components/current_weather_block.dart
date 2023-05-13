import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/extensions/size_extensions.dart';
import 'package:flutter_weather_app_api/models/current_weather_city.dart';

class CurrentWeatherBlock extends StatelessWidget {
  final CurrentWeatherCity currentWeatherCity;

  const CurrentWeatherBlock({Key? key, required this.currentWeatherCity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: context.percentHeight(0.31),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF010950),
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: context.percentHeight(0.01),
          left: context.percentHeight(0.02),
          right: context.percentHeight(0.01),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.network(
                'https:${currentWeatherCity.conditionIcon}',
                width: context.percentHeight(0.055),
              ),
            ),
            Text(
              '${currentWeatherCity.temperatureCelsius.toInt()}º',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              currentWeatherCity.conditionText,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: context.percentHeight(0.021),
                bottom: context.percentHeight(0.015),
              ),
              child: Text(
                '${currentWeatherCity.city.getNameAndCountry()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
