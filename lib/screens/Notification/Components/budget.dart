import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';

class Budget extends StatelessWidget {
  String category = "";
  String exceededBy = "";

  Budget(
      {required this.category,required this.exceededBy});
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
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$category',
                        style: mainHeader,
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    '+Rs: $exceededBy',
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
