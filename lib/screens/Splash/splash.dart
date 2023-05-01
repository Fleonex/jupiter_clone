import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jupiter_clone/responsive.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';

import '../../main.dart';

class Splash extends StatefulWidget{
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>{

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 1), (){
      Navigator.of(context).pushReplacement(CupertinoPageRoute (builder: (context) => const AuthWrap())
      );
    });
  }


  @override

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: softBlue,
      body: SizedBox(

        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/images/neptune-logo.png'),
              height: 300,
              width: 300,
            ),
            SpinKitSpinningLines(
              color: purple,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }


}