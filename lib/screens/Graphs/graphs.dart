import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/database.dart';

class Graphs extends StatefulWidget {
  const Graphs({Key? key}) : super(key: key);

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  List<Map<String, dynamic>> _transactions = [];
  Map<String, Map<String, double>> _monthlyExpenses = {};
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _categorizedTransactions();
  }

  void _fetchData() async{
    final List<Map<String, dynamic>>? res = await DatabaseService(uid: uid).getTransactions();
    if (res == null) {
      return;
    }
    setState(() {
      _transactions = res;
    });
  }

  void _categorizedTransactions() {
    for(int i = 0; i < _transactions.length; i++) {
      DateTime date = _transactions[i]['date'].toDate();
      String month = date.month.toString();
      String year = date.year.toString();

      if (_monthlyExpenses[year] == null) {
        _monthlyExpenses[year] = {};
      }
      if (_monthlyExpenses[year]![month] == null) {
        _monthlyExpenses[year]![month] = 0;
      }

      _monthlyExpenses[year]![month] = _monthlyExpenses[year]![month]! + _transactions[i]['amount'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      
    );
  }
}
