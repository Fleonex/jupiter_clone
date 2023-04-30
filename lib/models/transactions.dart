import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class Transaction {
  final String date;
  final String amount;
  final String description;

  Transaction(this.date, this.amount, this.description);

  Map<String, dynamic> toMap() {
    return {'date': date, 'amount': amount, 'description': description};
  }
}

void addTransaction(
    String func_date, String func_amount, String func_description) async {
  CollectionReference transactions =
      FirebaseFirestore.instance.collection('Transaction');

  Transaction transaction =
      Transaction(func_date, func_amount, func_description);
  Map<String, dynamic> transactionData = transaction.toMap();
  await transactions
      .add({
        "date": func_date,
        "amount": func_amount,
        "description": func_description
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));

  print("Added this into Transactions collection " +
      transactionData.toString() +
      "\n");
}
