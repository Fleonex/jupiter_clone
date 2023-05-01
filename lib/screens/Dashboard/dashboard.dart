import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:jupiter_clone/screens/Dashboard/components/transactionlist.dart';
import 'package:jupiter_clone/screens/forms/transaction_form.dart';
import 'package:jupiter_clone/services/database.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';
import 'package:jupiter_clone/screens/Dashboard/components/transaction.dart';
import 'package:jupiter_clone/excelsheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jupiter_clone/screens/Dashboard/components/transaction.dart'
as transactionFile;
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();

  const Dashboard({
    Key? key,
  }) : super(key: key);
}

// List<Widget> AllWidgets = [
//   Text('Widget 1'),
//   Text('Widget 2'),
//   Text('Widget 3'),
//   // ...
// ];

class _DashboardState extends State<Dashboard> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  double _totalExpenses = 0;
  late List<Widget> _widgetList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    List<Map<String, dynamic>>? snapshot = await DatabaseService(uid: uid).getTransactions();
    print("This is the snapshot $snapshot");
    // List<Widget> list = [];
    double total = 0;

    if (snapshot == null) {
      print("Snapshot is null");
      setState(() {
        _totalExpenses = total;
        _widgetList = [];
      });
      return;
    }

    List<Widget> list = [];

    for (int i = 0; i < snapshot.length; i++) {
      Map<String, dynamic> data = snapshot[i];
      total += data['amount'];

      DateTime date = data['date'].toDate();

      list.add(
        transactionFile.Transaction(
          amount: data['amount'].toString(),
          date: DateFormat('dd MMM yyyy').format(date).toString(),
          description: data['description'],
        )
      );
    }

    // print("\n\n\n\nThis is the total " + total.toString() + "\n");
    setState(() {
      _totalExpenses = total;
      _widgetList = list.reversed.toList();
    });

  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softBlue,
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 240,
            decoration: const BoxDecoration(
              color: purple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 60,
                left: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/user_photo.png', height: 50),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Howdy',
                            style: subTitle,
                          ),
                          Text(
                            'Kang Smile',
                            style: headerWhite,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset('assets/icons/ic_bell.png',
                                height: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Expenses',
                            style: subTitle,
                          ),
                          Text(
                            'Rs. $_totalExpenses',
                            style: largePrimary,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ..._widgetList
                ]
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TransactionForm(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),

      ),
    );
  }
}
