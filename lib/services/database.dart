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
        'totalExpenses': FieldValue.increment(transaction.amount),
        'noOfTransactions': FieldValue.increment(1),
      });


      return Future.value(true);
    } catch (e) {
      // print("An error occurred ,this is the error $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getTransactions() async{
    List<Map<String,dynamic>> transactions = [];

    final QuerySnapshot<Map<String, dynamic>> snapshot = await _userCollection.doc(uid).collection('transactions').get();

    for (var doc in snapshot.docs) {
      transactions.add(doc.data());

      // print("This is the doc ${transactions[transactions.length - 1]}");
    }

    return transactions;
  }
}