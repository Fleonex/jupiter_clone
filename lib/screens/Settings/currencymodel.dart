import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class currencyModel extends ChangeNotifier {
  String _currency = "INR";
  static String currenctCurrency = "INR";
  void changeCurrency(String currency) {
    currenctCurrency = currency;
    _currency = currency;
    notifyListeners();
  }

  String getCurrencyString(double currencyValue) {
    if (_currency == "INR") {
      return "₹ " + currencyValue.toStringAsFixed(2);
    } else if (_currency == "EUR") {
      double currencyinEuro = currencyValue / 89.83;
      return "€ " + currencyinEuro.toStringAsFixed(2);
    } else {
      double currencyinDollar = currencyValue / 81.77;
      return "\$ " + currencyinDollar.toStringAsFixed(2);
    }
  }
}
