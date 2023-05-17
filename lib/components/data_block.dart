import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/common/size_extensions.dart';

class DataBlock extends StatelessWidget {
  final String topIcon;
  final String midText;
  final String bottomText;

  const DataBlock(
      {Key? key,
      required this.topIcon,
      required this.midText,
      required this.bottomText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Image.asset(
            topIcon,
            height: context.percentHeight(0.03),
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.percentHeight(0.005)),
          child: Text(
            midText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
    );
  }
}
