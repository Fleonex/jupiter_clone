import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:jupiter_clone/screens/forms/transaction_form.dart';
import 'package:jupiter_clone/services/database.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';
import 'package:jupiter_clone/screens/Notification/Components/budget.dart'
    as budget_file;

class Notification extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();

  const Notification({
    Key? key,
  }) : super(key: key);
}

class _NotificationState extends State<Notification> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  double _totalExpenses = 0;
  late List<Widget> _widgetList = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SpinKitSpinningLines(color: purple)
        : Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              title: const Text("Notifications"),
              backgroundColor: purple,
            ),
            body: SingleChildScrollView(
              child: Column(children: [..._widgetList]),
            ),
          );
  }

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    List<Map<String, dynamic>>? budgetSnapShot =
        await DatabaseService(uid: uid).getCategories();
    List<Map<String, dynamic>>? snapshot =
        await DatabaseService(uid: uid).getTransactions();
    double total = 0;

    if (snapshot == null) {
      setState(() {
        _totalExpenses = total;
        _widgetList = [];
      });

      setState(() {
        _isLoading = false;
      });
      return;
    }
    Map<String, double> allExpenses = {};
    List<Widget> list = [];
    for (int i = 0; i < snapshot.length; i++) {
      Map<String, dynamic> data = snapshot[i];
      total += data['amount'];
      if (allExpenses[data['category']] == null) {
        allExpenses[data['category']] = 0.0;
      }
      allExpenses[data['category']] =
          allExpenses[data['category']]! + data['amount'];
    }

    for (int i = 0; i < budgetSnapShot!.length; i++) {
      if (allExpenses[budgetSnapShot[i]['category']] == null) {
        allExpenses[budgetSnapShot[i]['category']] = 0.0;
      }
      if (allExpenses[budgetSnapShot[i]['category']]! >
          budgetSnapShot[i]['limit']) {
        double difference =
            allExpenses[budgetSnapShot[i]['category'].toString()]! -
                budgetSnapShot[i]['limit'];
        list.add(budget_file.Budget(
            category: budgetSnapShot[i]['category'].toString(),
            exceededBy: difference));
        list.add(const SizedBox(
          height: 10,
        ));
      }
    }
    setState(() {
      _totalExpenses = total;
      _widgetList = list.reversed.toList();

      print(list.toString() + "\n");
      _isLoading = false;
    });
  }
}
