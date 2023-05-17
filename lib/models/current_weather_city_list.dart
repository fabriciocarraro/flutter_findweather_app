import 'package:flutter/material.dart';
import 'city.dart';
import 'current_weather_city.dart';

class CurrentWeatherCityList extends ChangeNotifier {
  List<CurrentWeatherCity> currentWeatherCityList;

  CurrentWeatherCityList({required this.currentWeatherCityList});

  void add(CurrentWeatherCity currentWeatherCity) {
    currentWeatherCityList.add(currentWeatherCity);
    notifyListeners();
  }

  void remove(CurrentWeatherCity currentWeatherCity) {
    currentWeatherCityList.removeWhere((element) =>
        element.city.getNameAndCountry() ==
        currentWeatherCity.city.getNameAndCountry());
    notifyListeners();
  }

  bool isCityInTheList(City city) {
    bool cityInTheList = false;

    for (CurrentWeatherCity currentWeatherCityItem in currentWeatherCityList) {
      if (city.getNameAndCountry() ==
          currentWeatherCityItem.city.getNameAndCountry()) {
        cityInTheList = true;
      }
    }
    return cityInTheList;
  }
}
