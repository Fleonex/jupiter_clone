import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';
import 'package:jupiter_clone/components/navbar.dart';

class Transaction extends StatefulWidget {

  @override
  _TransactionState createState() => _TransactionState();
  const Transaction({
    Key? key,
  }) : super(key: key);
}
List<Widget> AllWidgets = [
  Text('Widget 1'),
  Text('Widget 2'),
  Text('Widget 3'),
  // ...
];
class _TransactionState extends State<Transaction> {
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.asset(
            'assets/icons/ic_apple.png',
            height: 50,
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apple',
                style: mainHeader,
              ),
              Text(
                'AirPod Pro 3',
                style: paragraph,
              ),
            ],
          ),
          Spacer(),
          Text(
            '+\$5,320',
            style: labelBluePrimary,
          ),
        ]
      ),
      );
  }
}