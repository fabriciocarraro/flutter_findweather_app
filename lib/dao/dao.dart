import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/city.dart';

class Dao {
  saveCityAndCountry(City city) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> cityMap = {
      "id": city.id,
      "name": city.name,
      "region": city.region,
      "country": city.country
    };
    String encodedMap = jsonEncode(cityMap);
    await prefs.setString('citySaved', encodedMap);
  }

  Future<City?> loadCitySaved() async {
    final prefs = await SharedPreferences.getInstance();
    String? encodedMap = (prefs.getString('citySaved'));
    if (encodedMap != null && encodedMap != '') {
      Map<String, dynamic> decodedMap = jsonDecode(encodedMap);
      return City.fromMap(decodedMap);
    }
    return null;
  }

  removeSavedCity() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}