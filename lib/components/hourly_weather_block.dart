import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/common/size_extensions.dart';

class HourlyWeatherBlock extends StatelessWidget {
  final String topText;
  final String topIcon;
  final String bottomText;

  const HourlyWeatherBlock(
      {Key? key,
      required this.topText,
      required this.topIcon,
      required this.bottomText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.percentWidth(0.17),
      decoration: BoxDecoration(
        color: const Color(0xFF000045),
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.percentHeight(0.01)),
        child: Column(
          children: [
            Text(
              topText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Image.network(
                'https:$topIcon',
                height: context.percentHeight(0.05),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              bottomText,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
