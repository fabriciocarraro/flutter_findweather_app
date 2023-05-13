import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/extensions/size_extensions.dart';
import 'package:flutter_weather_app_api/screens/home_sub_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000031),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.percentWidth(0.05)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.percentHeight(0.17)),
              child: Image.asset('assets/images/cloud-and-thunder.png'),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: context.percentHeight(0.05)),
              child: const Text(
                'Check the weather\nin your city',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                ),
              ),
            ),
            const Text(
              'With FindWeather you get the weather forecast at the palm of your hand',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 22,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: context.percentHeight(0.1),
                  bottom: context.percentHeight(0.02)),
              child: SizedBox(
                width: context.percentWidth(0.9),
                height: context.percentHeight(0.07),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeSubScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  child: const Text(
                    'Open',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
