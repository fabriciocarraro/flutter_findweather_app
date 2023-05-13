import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/extensions/size_extensions.dart';
import 'package:flutter_weather_app_api/screens/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/hourly_weather_block.dart';
import '../components/data_block.dart';
import '../models/city.dart';
import '../models/current_weather_city.dart';
import '../services/api_service.dart';

class HomeSubScreen extends StatefulWidget {
  const HomeSubScreen({Key? key}) : super(key: key);

  @override
  State<HomeSubScreen> createState() => _HomeSubScreenState();
}

class _HomeSubScreenState extends State<HomeSubScreen> {
  City? citySaved;
  CurrentWeatherCity? currentWeatherCity;

  Future<void> _loadCitySaved() async {
    final prefs = await SharedPreferences.getInstance();
    String encodedMap = (prefs.getString('citySaved') ?? '');
    if (encodedMap != '') {
      Map<String, dynamic> decodedMap = jsonDecode(encodedMap);
      setState(() {
        citySaved = City.fromMap(decodedMap);
      });
    }
  }

  Future<void> _getCurrentWeather() async {
    ApiService service = ApiService();
    setState(() async {
      currentWeatherCity = await service.getCurrentWeather(citySaved!);
    });
  }

  @override
  void initState() {
    super.initState();

    _loadCitySaved().then((value) {
      if(citySaved != null) {
        _getCurrentWeather();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (citySaved == null)
        ? _emptyHome(context)
        : _cityHome(context);
  }

  Widget _emptyHome(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.percentWidth(0.05)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.percentHeight(0.1)),
              child: const Text(
                'FindWeather',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: context.percentHeight(0.13)),
              child: Image.asset('assets/images/climate-change.png'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const MainPage(selectedIndex: 1),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: const Text(
                'Click here to choose your base city and check the weather in real time',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.grey,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cityHome(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.percentWidth(0.05)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.percentHeight(0.04)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Colors.white,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentWeatherCity!.city.getNameAndCountry(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Domingo, 01 Jan de 2023',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: context.percentHeight(0.03),
                  bottom: context.percentHeight(0.02)),
              child: Image.network(
                'https:${currentWeatherCity!.conditionIcon}',
              ),
            ),
            Text(
              currentWeatherCity!.temperatureCelsius.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 76,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              currentWeatherCity!.conditionText,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 30,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: context.percentHeight(0.03)),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: context.percentHeight(0.01),
                      horizontal: context.percentHeight(0.02)),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DataBlock(
                            topIcon: Icons.water_drop,
                            midText: currentWeatherCity!.humidity.toString(),
                            bottomText: 'Humidity'),
                        const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        DataBlock(
                            topIcon: Icons.wind_power,
                            midText: '${currentWeatherCity!.windSpeedKph} km/h',
                            bottomText: 'Wind speed'),
                        const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        DataBlock(
                            topIcon: Icons.cloud,
                            midText: '${currentWeatherCity!.cloudCoverage.toString()}%',
                            bottomText: 'Clouds'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Hoje',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Próximos 5 dias >',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: context.percentHeight(0.02)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HourlyWeatherBlock(
                      topText: '23º',
                      topIcon: Icons.sunny,
                      bottomText: '09:00'),
                  HourlyWeatherBlock(
                      topText: '18º',
                      topIcon: Icons.cloud,
                      bottomText: '13:00'),
                  HourlyWeatherBlock(
                      topText: '8º', topIcon: Icons.sunny, bottomText: '17:00'),
                  HourlyWeatherBlock(
                      topText: '28º',
                      topIcon: Icons.cloud,
                      bottomText: '23:00'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
