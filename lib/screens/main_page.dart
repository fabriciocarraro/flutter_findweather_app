import 'package:flutter/material.dart';
import 'package:flutter_weather_app_api/screens/home_sub_screen.dart';
import 'package:flutter_weather_app_api/screens/search_sub_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  final int? selectedIndex;

  const MainPage({Key? key, this.selectedIndex}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;
  final List<Widget> _screens = [
    const HomeSubScreen(),
    const SearchSubScreen(),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.selectedIndex != null ? _selectedIndex = widget.selectedIndex! : 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: AppBar(
                backgroundColor: Colors.transparent, // 1
                elevation: 0, // 2
                title: const Text(
                  'FindWeather',
                  style: TextStyle(
                    color: Colors.white, // 3
                  ),
                ),
              ),
            )
          : AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const MainPage(selectedIndex: 0),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
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
      body: _screens[_selectedIndex],
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
