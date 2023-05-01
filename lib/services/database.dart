import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:jupiter_clone/models/transactions.dart';

class DatabaseService with ChangeNotifier {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future? addCategory(String category, double limit) async {
    try {
      Map<String, dynamic> categoryData = {
        'category': category,
        'limit': limit,
      };

      _userCollection.doc(uid).collection('Categories').doc(category).set({
        'limit': limit,
      });

      return Future.value(true);
    } catch (e) {
      // print("An error occurred ,this is the error $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>>? getCategories() async {
    List<Map<String, dynamic>> categories = [];

    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _userCollection.doc(uid).collection('Categories').get();

    print("This is the snapshot $snapshot");

    for (var doc in snapshot.docs) {
      categories.add(doc.data());
      print("This is the doc ${categories[categories.length - 1]}");
      categories[categories.length - 1]['category'] = doc.id;
    }

    return categories;
  }

  Future? updateCategory(String category, double limit) async {
    try {
      Map<String, dynamic> categoryData = {
        'category': category,
        'limit': limit,
      };

      _userCollection.doc(uid).collection('Categories').doc(category).update({
        'limit': limit,
      });

      return Future.value(true);
    } catch (e) {
      // print("An error occurred ,this is the error $e");
      return null;
    }
  }

  Future? addTransaction(Transactions transaction) {
    try {
      Map<String, dynamic> transactionData = transaction.toMap();
      transactionData['creationDate'] = Timestamp.now();

      _userCollection.doc(uid).collection('transactions').add(transactionData);

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

  Future<List<Map<String, dynamic>>?> getTransactions() async {
    List<Map<String, dynamic>> transactions = [];

    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _userCollection.doc(uid).collection('transactions').get();

    for (var doc in snapshot.docs) {
      transactions.add(doc.data());

      // print("This is the doc ${transactions[transactions.length - 1]}");
    }

    return transactions;
  }
}
