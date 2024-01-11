import 'package:argo_smart_v1/page/homePage.dart';
import 'package:argo_smart_v1/page/tesTombol.dart';
import 'package:argo_smart_v1/schdule/schedule.dart';
import 'package:argo_smart_v1/page/setingPage.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _MyAppState();
}

class _MyAppState extends State<NavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: HomePage()),
    Center(child: TombolTes()),
    Center(child: SetingingPage()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Scheduling',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          fixedColor: Colors.black,
        ),
      ),
    );
  }
}
