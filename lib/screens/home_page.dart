import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/extensions/size_extensions.dart';

import '../components/hourly_weather_block.dart';
import '../components/data_block.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000031),
      body: _cityHome(context),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF000031),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
          ],
        ),
      ),
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
            const Text(
              'Choose your base city and check the weather in real time',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 22,
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
              padding: EdgeInsets.only(top: context.percentHeight(0.08)),
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
                        'São Paulo, Brasil',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
              child: Image.asset('assets/images/raining.png'),
            ),
            const Text(
              '23ºC',
              style: TextStyle(
                color: Colors.white,
                fontSize: 76,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Chuva moderada',
              style: TextStyle(
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
                            midText: '24%',
                            bottomText: 'Umidade'),
                        const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        DataBlock(
                            topIcon: Icons.wind_power,
                            midText: '20km/h',
                            bottomText: 'Veloc. Vento'),
                        const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        DataBlock(
                            topIcon: Icons.cloud,
                            midText: '76%',
                            bottomText: 'Chuva'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hoje',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const Text(
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
