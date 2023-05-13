import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/components/current_weather_block.dart';
import 'package:flutter_weather_app_api/extensions/size_extensions.dart';
import 'package:flutter_weather_app_api/models/current_weather_city.dart';
import 'package:flutter_weather_app_api/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/city.dart';
import 'main_page.dart';

class SearchSubScreen extends StatefulWidget {
  const SearchSubScreen({Key? key}) : super(key: key);

  @override
  State<SearchSubScreen> createState() => _SearchSubScreenState();
}

class _SearchSubScreenState extends State<SearchSubScreen> {
  ApiService service = ApiService();
  City? selectedCity;
  List<City> cityList = [];
  List<CurrentWeatherCity> currentWeatherCityList = [];
  TextEditingController textEdController = TextEditingController();

  Future<void> _updateAutocomplete(String text) async {
    if (text.length > 2) {
      List<City> results = await service.getSearchResults(text);
      setState(() {
        cityList = results;
      });
    } else {
      setState(() {
        cityList.clear();
      });
    }
  }

  _saveCityAndCountry(City city) async {
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

  Future<void> _navigateToMainPage() async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainPage(selectedIndex: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.percentHeight(0.03)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: context.percentWidth(0.02)),
                child: SizedBox(
                  width: context.percentWidth(0.82),
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Autocomplete<City>(
                        optionsBuilder: (textEdController) async {
                          if (textEdController.text == '') {
                            return const Iterable<City>.empty();
                          } else {
                            await _updateAutocomplete(textEdController.text);
                            return cityList;
                          }
                        },
                        displayStringForOption: (City option) =>
                            '${option.name}, ${option.country}',
                        fieldViewBuilder: (context, textEdController, focusNode,
                            onEditingComplete) {
                          return TextField(
                            controller: textEdController,
                            cursorColor: Colors.white,
                            enableSuggestions: false,
                            autocorrect: false,
                            focusNode: focusNode,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
                                color: Colors.white,
                                onPressed: () async {
                                  if (currentWeatherCityList.length < 4) {
                                    CurrentWeatherCity currentWeatherCity =
                                        await service
                                            .getCurrentWeather(selectedCity!);

                                    currentWeatherCityList
                                        .add(currentWeatherCity);

                                    if (currentWeatherCityList.length == 1) {
                                      await _saveCityAndCountry(
                                          currentWeatherCity.city);

                                      _navigateToMainPage();
                                    }
                                  }
                                  textEdController.text = '';
                                  cityList.clear();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {});
                                },
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              hintText: 'Type the name of a city...',
                              hintStyle: const TextStyle(color: Colors.grey),
                              fillColor: const Color(0xFF000045),
                              filled: true,
                            ),
                          );
                        },
                        onSelected: (City city) {
                          selectedCity = city;
                        },
                      );
                    },
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF000045),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                width: context.percentWidth(0.1),
                height: context.percentHeight(0.081),
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: context.percentWidth(0.05),
              right: context.percentWidth(0.05),
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 10,
                mainAxisExtent: context.percentHeight(0.31),
              ),
              itemCount: currentWeatherCityList.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: CurrentWeatherBlock(
                      currentWeatherCity: currentWeatherCityList[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
