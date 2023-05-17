import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/common/size_extensions.dart';
import 'package:flutter_weather_app_api/screens/main_page.dart';
import '../components/hourly_weather_block.dart';
import '../components/data_block.dart';
import '../dao/dao.dart';
import '../models/current_weather_city.dart';
import '../services/api_service.dart';

class HomeSubScreen extends StatefulWidget {
  const HomeSubScreen({Key? key}) : super(key: key);

  @override
  State<HomeSubScreen> createState() => _HomeSubScreenState();
}

class _HomeSubScreenState extends State<HomeSubScreen> {
  ApiService service = ApiService();
  Dao dao = Dao();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getSavedCityAndItsCurrentWeather(),
      builder: (context, snapshot) {
        CurrentWeatherCity? citySaved = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text('Loading'),
                ],
              ),
            );
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text('Loading'),
                ],
              ),
            );
          case ConnectionState.active:
            return Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text('Loading'),
                ],
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasData && citySaved != null) {
              return _cityHome(context, citySaved);
            }
            return _emptyHome(context);
        }
      },
    );
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

  Widget _cityHome(
      BuildContext context, CurrentWeatherCity currentWeatherCity) {
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
                        currentWeatherCity.city.getNameAndCountry(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        DateFormat('EEEE, MMMM d, y')
                            .format(DateTime.now()),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
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
                top: context.percentHeight(0.02),
              ),
              child: Image.network(
                'https:${currentWeatherCity.conditionIcon}',
                height: context.percentHeight(0.21),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              '${currentWeatherCity.temperatureCelsius.toInt().toString()}º ',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 76,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              currentWeatherCity.conditionText,
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
                            topIcon: 'assets/images/drop-miniature.png',
                            midText:
                                '${currentWeatherCity.humidity.toString()}%',
                            bottomText: 'Humidity'),
                        const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        DataBlock(
                            topIcon: 'assets/images/wind-miniature.png',
                            midText: '${currentWeatherCity.windSpeedKph} km/h',
                            bottomText: 'Wind speed'),
                        const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        DataBlock(
                            topIcon: 'assets/images/nuvem.png',
                            midText:
                                '${currentWeatherCity.cloudCoverage.toString()}%',
                            bottomText: 'Clouds'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Hoje',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                // Text(
                //   'Próximos 5 dias >',
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 20,
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: context.percentHeight(0.02)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HourlyWeatherBlock(
                      topText:
                          '${currentWeatherCity.temperature9AM.toInt().toString()}º',
                      topIcon: currentWeatherCity.icon9AM,
                      bottomText: '09:00'),
                  HourlyWeatherBlock(
                      topText:
                          '${currentWeatherCity.temperature1PM.toInt().toString()}º',
                      topIcon: currentWeatherCity.icon1PM,
                      bottomText: '13:00'),
                  HourlyWeatherBlock(
                      topText:
                          '${currentWeatherCity.temperature5PM.toInt().toString()}º',
                      topIcon: currentWeatherCity.icon5PM,
                      bottomText: '17:00'),
                  HourlyWeatherBlock(
                      topText:
                          '${currentWeatherCity.temperature11PM.toInt().toString()}º',
                      topIcon: currentWeatherCity.icon11PM,
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
