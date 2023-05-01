import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:jupiter_clone/models/transactions.dart';

class DatabaseService with ChangeNotifier{
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  Future? addTransaction(Transactions transaction)  {
    try {
      Map<String, dynamic> transactionData = transaction.toMap();
      transactionData['creationDate'] = Timestamp.now();

      _userCollection.doc(uid).collection('transactions').add(
          transactionData
      );

      _userCollection.doc(uid).update({
        'totalExpenses': FieldValue.increment(transaction.amount as num),
        'noOfTransactions': FieldValue.increment(1),
      });


      return Future.value(true);
    } catch (e) {
      print("An error occured ,this is the error $e");
      return null;
    }
  }

  List<Map<String, dynamic>> _transactionsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
  }

  List<Map<String, dynamic>>? getTransactions() {
    _userCollection.doc(uid).collection('transactions').get().then((value) {
      return _transactionsListFromSnapshot(value);
    });
  }
}