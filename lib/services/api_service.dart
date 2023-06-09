import 'dart:convert';
import 'package:flutter_weather_app_api/models/current_weather_city.dart';
import 'package:http/http.dart' as http;
import '../auth/api_keys.dart';
import '../dao/dao.dart';
import '../models/city.dart';

class ApiService {
  Dao dao = Dao();
  final String url = 'http://api.weatherapi.com/v1';
  final String search = '/search.json';
  final String currentWeather = '/forecast.json';
  final String cityProp = '&q=';
  final String numDays = '&days=1';
  final String leaveOut = '&aqi=no&alerts=no';

  _getSearchUrl(String cityChars) {
    return '$url$search$API_KEY_WEATHER_API$cityProp$cityChars';
  }

  _getCurrentWeatherUrl(String cityName) {
    return '$url$currentWeather$API_KEY_WEATHER_API$cityProp$cityName$numDays$leaveOut';
  }

  Future<List<City>> getSearchResults(String cityChars) async {
    List<City> cityList = [];

    http.Response response = await http.get(Uri.parse(_getSearchUrl(cityChars)),
        headers: {'Content-type': 'application/json'});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      for (var city in jsonData) {
        cityList.add(City.fromMap(city));
      }
      return cityList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<CurrentWeatherCity?> getSavedCityAndItsCurrentWeather() async {
    City? citySaved = await dao.loadCitySaved();
    if (citySaved != null) {
      return await getCurrentWeatherForCity(citySaved);
    }
    return null;
  }

  Future<CurrentWeatherCity> getCurrentWeatherForCity(City city) async {
    http.Response response = await http.get(
        Uri.parse(_getCurrentWeatherUrl(city.getNameAndCountry())),
        headers: {'Content-type': 'application/json'});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return CurrentWeatherCity.fromMap(city, jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
