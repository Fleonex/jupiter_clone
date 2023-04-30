import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jupiter_clone/screens/Dashboard/transaction.dart'
    as transactionFile;

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  List<Widget> _widgetList = [];
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Transactions').get();

    print("This is the snapshot " + snapshot.toString());
    List<Widget> list = [];
    list.add(transactionFile.Transaction());
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      list.add(transactionFile.Transaction());
    });
    setState(() {
      _widgetList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 300, // adjust the height to your needs
        child: SingleChildScrollView(
          child: Column(
            children: _widgetList,
          ),
        ),
    );
  }
}
