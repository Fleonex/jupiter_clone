import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:jupiter_clone/models/transactions.dart';

class DatabaseService extends ChangeNotifier{
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  Future addTransaction(Transactions transaction)  {
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
      return Future.value(false);
    }
  }

  List<Map<String, dynamic>> _transactionsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
  }

  Stream<List<Map<String, dynamic>>> get transactions {
    final res =  _userCollection.doc(uid).collection('transactions').snapshots().map(_transactionsListFromSnapshot);
    notifyListeners();
    return res;
  }
}