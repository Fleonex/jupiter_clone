import 'package:flutter/material.dart';
import 'package:jupiter_clone/services/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: _auth.signOut,
        child: const Text("Sign Out"),
      ),
    );
  }
}
