import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jupiter_clone/screens/Dashboard/home.dart';
import 'package:jupiter_clone/services/auth.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                "Verify your email address by clicking the link in the email we sent you."),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (FirebaseAuth.instance.currentUser!.emailVerified) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please verify your email address."),
                    ),
                  );
                }
              },
              child: const Text("Continue"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  AuthService().signOut();
                  // Navigator.of(context).pop();
                },
                child: const Text("Go back")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.currentUser!
                    .sendEmailVerification();
              },
              child: const Text("Resend verification email"),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
