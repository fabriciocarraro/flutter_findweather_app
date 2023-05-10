import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/extensions/size_extensions.dart';
import 'package:flutter_weather_app_api/services/api_service.dart';
import '../models/city.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 1;
  ApiService service = ApiService();
  List<City> cityList = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF000031),
        shadowColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF000031),
      body: Padding(
        padding: EdgeInsets.only(top: context.percentHeight(0.03)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: context.percentWidth(0.02)),
              child: SizedBox(
                width: context.percentWidth(0.7),
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Autocomplete<City>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text == '') {
                        return const Iterable<City>.empty();
                      } else {
                        await _updateAutocomplete(textEditingValue.text);
                        print('\n---------------------------');
                        print(textEditingValue.text);
                        print(cityList);
                        print('\n---------------------------');
                        return cityList;
                      }
                    },
                    displayStringForOption: (City option) =>
                        '${option.name}, ${option.country}',
                    fieldViewBuilder: (context, textController, focusNode,
                        onEditingComplete) {
                      return TextField(
                        controller: textController,
                        cursorColor: Colors.white,
                        enableSuggestions: false,
                        autocorrect: false,
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          hintText: 'Type the name of a city...',
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Color(0xFF000045),
                          filled: true,
                        ),
                      );
                    },
                    onSelected: (City city){
                      service.getCurrentWeather('${city.name}, ${city.country}');
                    },
                  );
                }),
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
}
