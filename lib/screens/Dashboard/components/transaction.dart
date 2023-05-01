import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';




class Transaction extends StatelessWidget {
  String date="";
  String amount="";
  String description="";

  Transaction({required this.date,required this.amount,required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                  child: Column(children: [
                Row(children: [
                  Image.asset(
                    'assets/icons/ic_apple.png',
                    height: 50,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$date',
                        style: mainHeader,
                      ),
                      Text(
                        '$description',
                        style: paragraph,
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    '+Rs: $amount',
                    style: labelBluePrimary,
                  ),
                ]),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
