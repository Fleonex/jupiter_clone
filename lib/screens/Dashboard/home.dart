import 'package:flutter/material.dart';
import 'package:jupiter_clone/screens/Dashboard/dashboard.dart';
import 'package:jupiter_clone/style/color.dart';


import '../Graphs/graphs.dart';
import '../Profile/profile.dart';
import '../Budget/budget.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Graphs(),
    BudgetingPage(),
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
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  backgroundColor: black,
                  // Display label when selected
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.graphic_eq),
                  backgroundColor: black,
                  label: 'Graphs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.money),
                  backgroundColor: black,
                  label: 'Budget',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
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
