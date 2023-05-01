import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jupiter_clone/screens/Dashboard/components/transaction.dart'
    as transactionFile;
import 'package:provider/provider.dart';

import '../../../services/database.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  List<Widget> _widgetList = [];
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    // final snapshot = DatabaseService(uid: uid).getTransactions();
    // // print("This is the snapshot $snapshot");
    // List<Widget> list = [];
    //
    // if (snapshot == null) {
    //   return;
    // }
    //
    // for (var doc in snapshot) {
    //   Map<String, dynamic> data = doc;
    //   list.add(transactionFile.Transaction(
    //     amount: data['amount'],
    //     date: data['date'],
    //     description: data['description'],
    //   ));
    //
    //   print("This is the doc $doc");
    // }
    //
    // setState(() {
    //   _widgetList = list.reversed.toList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          ..._widgetList,
        ],
      ),
    ));
  }
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => DatabaseService(uid: uid),
  //     child: ListView.builder(
  //       itemCount: _widgetList.length,
  //       itemBuilder: (context, index) {
  //         return _widgetList[index];
  //       },
  //     ),
  //   );
  // }
}
