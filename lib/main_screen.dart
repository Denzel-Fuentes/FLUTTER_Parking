import 'package:flutter/material.dart';
import 'package:parking_app/OffersPropose.dart';
import 'package:parking_app/Profile_screen.dart';
import 'package:parking_app/map_screen.dart';

void main() async {

  runApp(MaterialApp(
      title: 'Parking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: MainScreen()
    )
  );
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    MapScreen(),
    OffersProposeTAB(),
    ProfileScreen()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor:
              Colors.white, 
        ),
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Mapa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: 'Movimientos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Perfil', 
            ),
          ],
          selectedItemColor: Color.fromARGB(255, 41, 90, 158),
          unselectedItemColor: Color.fromARGB(240, 43, 44, 40).withOpacity(0.7),
        ),
      ),
    );
  }
}
