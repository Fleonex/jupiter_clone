import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../style/constants.dart';
import '../../Login/login_screen.dart';
import 'package:jupiter_clone/services/auth.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
  const SignUpForm({
    Key? key,
  }) : super(key: key);
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email = "";
  String _password = "";
  bool _showPassword = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
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
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: (_showPassword == true)
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  hintText: "Your password",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            ElevatedButton(
              onPressed: () async {
                // print("This is email " + _emailController.text + "\n");
                // print("This is password " + _passwordController.text + "\n");
                var authClass = AuthService();
                var currentUser = authClass.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text);
                Navigator.of(context).pop();
                // var currentUser = "Hello World";
                // print("The current User is " + currentUser.toString());
              },
              child: Text("Sign Up".toUpperCase()),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
