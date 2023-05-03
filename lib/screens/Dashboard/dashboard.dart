import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:jupiter_clone/screens/forms/transaction_form.dart';
import 'package:jupiter_clone/services/database.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';
import 'package:jupiter_clone/screens/Dashboard/components/transaction.dart'
    as transaction_file;
import 'package:jupiter_clone/screens/Notification/notification.dart'
    as notificationfile;
import 'package:provider/provider.dart';
import 'package:jupiter_clone/screens/Settings/currencymodel.dart';

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
  bool _isLoading = false;
  String email = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    List<Map<String, dynamic>>? snapshot =
        await DatabaseService(uid: uid).getTransactions();
    // print("This is the snapshot $snapshot");
    // List<Widget> list = [];
    double total = 0;

    if (snapshot == null) {
      // print("Snapshot is null");
      setState(() {
        _totalExpenses = total;
        _widgetList = [];
      });

      setState(() {
        _isLoading = false;
      });

      return;
    }

    List<Widget> list = [];

    for (int i = 0; i < snapshot.length; i++) {
      Map<String, dynamic> data = snapshot[i];
      total += data['amount'];

      DateTime date = data['date'].toDate();

      list.add(transaction_file.Transaction(
        amount: data['amount'],
        date: DateFormat('dd MMM yyyy').format(date).toString(),
        category: data['category'],
        description: data['description'],
      ));
      list.add(const SizedBox(
        height: 10,
      ));
    }

    // print("\n\n\n\nThis is the total " + total.toString() + "\n");
    setState(() {
      _totalExpenses = total;
      _widgetList = list.reversed.toList();
      _isLoading = false;
    });
    // dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SpinKitSpinningLines(color: purple)
        : Consumer<currencyModel>(
            builder: (context, currency, child) => Scaffold(
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
                              Image.asset('assets/images/user_photo.png',
                                  height: 50),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Howdy',
                                    style: subTitle,
                                  ),
                                  Text(
                                    email,
                                    style: headerWhite,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              (notificationfile.Notification()),
                                        ),
                                      );
                                    },
                                    icon: Image.asset(
                                        'assets/icons/ic_bell.png',
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
                                    currency.getCurrencyString(_totalExpenses),
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
                  Container(
                      height: 1870,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(children: [..._widgetList]),
                            const SizedBox(
                              height: 150,
                            )
                          ],
                        ),
                      )),
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
            ),
          );
  }
}
