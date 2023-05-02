import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';
import 'package:provider/provider.dart';
import 'package:jupiter_clone/screens/Settings/currencymodel.dart';

class Transaction extends StatelessWidget {
  String date = "";
  double amount = 0;
  String description = "";

  Transaction(
      {required this.date, required this.amount, required this.description});

  @override
  Widget build(BuildContext context) {
    // final currencyConverter =
    //     Provider.of<currencyModel>(context, listen: false);
    // String currency = currencyConverter.getCurrencyString(amount);
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
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: const Icon(
                        Icons.monetization_on,
                        color: Colors.green,
                        size: 50,
                      ),
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
                      currency.getCurrencyString(amount),
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
