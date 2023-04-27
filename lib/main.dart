import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jupiter_clone/firebase_options.dart';
import 'package:jupiter_clone/screens/home.dart';
import 'package:jupiter_clone/screens/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthWrap(),
    );
  }
}

class AuthWrap extends StatelessWidget {
  const AuthWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // ! TODO: Add a Sign In Page
          return const SignInPage();
        } else {
          // ! TODO: Add a Home Page
          return const HomePage();
        }
      },
    );
  }
}
