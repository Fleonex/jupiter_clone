import 'package:flutter/material.dart';
import 'package:jupiter_clone/services/auth.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  late String email;
  late String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void signIn() async {
    final user = await _auth.signInWithEmailAndPassword(email, password);

    if (user == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign In Failed"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Sign In"),
        ),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      email = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                    obscureText: true,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      password = value!;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        signIn();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Sign In Failed"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                ],
              )
            ),
            SignInButton(
              buttonType: ButtonType.google,
              buttonSize: ButtonSize.large,
              onPressed: _auth.signInWithGoogle,
            ),
          ],
        ),
      );
  }
}
