import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/extensions/size_extensions.dart';

class DataBlock extends StatelessWidget {
  final IconData topIcon;
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
        Icon(
          topIcon,
          color: Colors.white,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.percentHeight(0.005)),
          child: Text(
            midText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          bottomText,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
