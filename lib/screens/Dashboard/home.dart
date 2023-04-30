import 'package:flutter/material.dart';
import 'package:jupiter_clone/screens/Dashboard/dashboard.dart';
import 'package:jupiter_clone/style/color.dart';

import '../Profile/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Placeholder(),
    Placeholder(),
    ProfilePage(),
  ];

  void setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: black,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade800,
                blurRadius: 5,
                spreadRadius: 0,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: BottomNavigationBar(
              enableFeedback: true,
              backgroundColor: black,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  backgroundColor: black,
                  // Display label when selected
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.graphic_eq),
                  backgroundColor: black,
                  label: 'Graphs',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.money),
                  backgroundColor: black,
                  label: 'Budget',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  backgroundColor: black,
                  label: 'Profile',
                ),
              ],
              type: BottomNavigationBarType.shifting,
              currentIndex: _selectedIndex,
              showUnselectedLabels: false,
              onTap: setIndex,
              elevation: 5,
              iconSize: 30,
            ),
          ),
        ));
  }
}
