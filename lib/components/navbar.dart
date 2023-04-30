import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jupiter_clone/style/color.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();

  const Navbar({
    Key? key,
  }) : super(key: key);
}

class _NavbarState extends State<Navbar> {
    // a function that returns a widget for the menu bar

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          // add border radius to only top side
          decoration: BoxDecoration(
              color: black,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12)
              )

          ),

        ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),

          child: GNav(
              backgroundColor: black,
              color: white,
              activeColor: white,
              tabBackgroundColor: Colors.grey.shade900,
              gap: 3,
              padding: const EdgeInsets.all(16),
              tabs: const[
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.graphic_eq,
                  text: 'Graphs',
                ),
                GButton(
                  icon: Icons.money,
                  text: 'Budget',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ]
          ),
        ),
    ),
    );
  }
}