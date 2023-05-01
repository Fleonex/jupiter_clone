import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:jupiter_clone/components/already_have_an_account_acheck.dart';
import 'package:jupiter_clone/style/constants.dart';
import '../../Signup/signup_screen.dart';

import 'package:jupiter_clone/services/auth.dart';
import 'package:jupiter_clone/style/color.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
  const LoginForm({
    Key? key,
  }) : super(key: key);
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email = "";
  String _password = "";
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading ? SpinKitSpinningLines(color: purple):SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {
                _email = email.toString();
              },
              decoration: const InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(

                controller: _passwordController,
                textInputAction: TextInputAction.done,
                obscureText: !_showPassword,
                cursorColor: kPrimaryColor,
                onSaved: (password) {
                  _password = password.toString();
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: _showPassword==true ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                  ),
                  hintText: "Your password",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    _formKey.currentState!.save();
                    dynamic result = await AuthService().signInWithEmailAndPassword(_email, _password);
                    if (result == null) {
                      if (mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid Credentials"),
                        ),
                      );

                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
                child: Text(
                  "Login".toUpperCase(),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
