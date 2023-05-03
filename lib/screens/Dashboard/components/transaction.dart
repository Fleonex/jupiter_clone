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

  String category = "";
  Transaction(
      {required this.date,
      required this.amount,
      required this.description,
      required this.category});

  Widget _buildDetailsItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  void _showDetailsPopup(BuildContext context, currencyModel currency) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Expense Details",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                _buildDetailRow("Date", date),
                _buildDetailRow("Category", category),
                _buildDetailRow("Description", description),
                _buildDetailRow("Amount", currency.getCurrencyString(amount)),
                SizedBox(height: 16.0),
                TextButton(
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(color: Colors.purple),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final currencyConverter =
    //     Provider.of<currencyModel>(context, listen: false);
    // String currency = currencyConverter.getCurrencyString(amount);
    return Consumer<currencyModel>(
      builder: (context, currency, child) => GestureDetector(
        onTap: () {
          _showDetailsPopup(context, currency);
        },
        child: Padding(
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
                            '$category',
                            style: mainHeader,
                          ),
                          Text(
                            '$date',
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
      ),
    );
  }
}
