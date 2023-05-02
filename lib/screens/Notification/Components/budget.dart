import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';
import 'package:provider/provider.dart';
import 'package:jupiter_clone/screens/Settings/currencymodel.dart';

class Budget extends StatelessWidget {
  String category = "";
  double exceededBy = 0.0;

  Budget({required this.category, required this.exceededBy});
  @override
  Widget build(BuildContext context) {
    return Consumer<currencyModel>(
      builder: (context, currency, child) => Padding(
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
                      currency.getCurrencyString(exceededBy),
                      style: labelBluePrimary,
                    ),
                  ]),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
