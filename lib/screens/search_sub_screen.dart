import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/components/current_weather_block.dart';
import 'package:flutter_weather_app_api/common/size_extensions.dart';
import 'package:flutter_weather_app_api/models/current_weather_city.dart';
import 'package:flutter_weather_app_api/models/current_weather_city_list.dart';
import 'package:flutter_weather_app_api/services/api_service.dart';
import 'package:provider/provider.dart';
import '../common/confirmation_dialog.dart';
import '../dao/dao.dart';
import '../models/city.dart';
import 'main_page.dart';

class SearchSubScreen extends StatefulWidget {
  const SearchSubScreen({Key? key}) : super(key: key);

  @override
  State<SearchSubScreen> createState() => _SearchSubScreenState();
}

class _SearchSubScreenState extends State<SearchSubScreen> {
  ApiService service = ApiService();
  Dao dao = Dao();
  City? selectedCity;
  List<City> cityList = [];
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

  Future<void> _navigateToMainPage() async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainPage(selectedIndex: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentWeatherCityList>(
      builder:
          (BuildContext context, CurrentWeatherCityList cwcl, Widget? widget) {
        return Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: context.percentHeight(0.03)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: context.percentWidth(0.02)),
                    child: SizedBox(
                      width: context.percentWidth(0.82),
                      child: Autocomplete<City>(
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
                                  if ((cwcl.currentWeatherCityList.length <
                                          4) &&
                                      (!cwcl.isCityInTheList(selectedCity!))) {
                                    CurrentWeatherCity currentWeatherCity =
                                        await service.getCurrentWeatherForCity(
                                            selectedCity!);

                                    cwcl.add(currentWeatherCity);

                                    if (cwcl.currentWeatherCityList.length ==
                                        1) {
                                      await dao.saveCityAndCountry(
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
            FutureBuilder(
              future: service.getSavedCityAndItsCurrentWeather(),
              builder: (context, snapshot) {
                CurrentWeatherCity? currentWeatherCitySaved = snapshot.data;
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
                    if (snapshot.hasData && currentWeatherCitySaved != null) {
                      if (!cwcl.isCityInTheList(currentWeatherCitySaved.city)) {
                        cwcl.add(currentWeatherCitySaved);
                      }
                    }
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: context.percentWidth(0.05),
                          right: context.percentWidth(0.05),
                        ),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 10,
                            mainAxisExtent: context.percentHeight(0.31),
                          ),
                          itemCount: cwcl.currentWeatherCityList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onLongPress: () {
                                CurrentWeatherCity selectedWeatherCity =
                                    cwcl.currentWeatherCityList[index];

                                showConfirmationDialog(context,
                                        content:
                                            "Do you want to remove ${selectedWeatherCity.city.getNameAndCountry()}?",
                                        affirmativeOption: "Yes")
                                    .then((value) {
                                  if (value != null && value) {
                                    cwcl.remove(selectedWeatherCity);
                                    if (currentWeatherCitySaved != null &&
                                        selectedWeatherCity.city
                                                .getNameAndCountry() ==
                                            currentWeatherCitySaved.city
                                                .getNameAndCountry()) {
                                      dao.removeSavedCity();
                                    }
                                    setState(() {});
                                  }
                                });

                              },
                              child: SingleChildScrollView(
                                child: CurrentWeatherBlock(
                                    currentWeatherCity:
                                        cwcl.currentWeatherCityList[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
