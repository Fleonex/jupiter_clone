import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

final db = FirebaseFirestore.instance;

class Transactions {
  final DateTime date;
  final num amount;
  final String description;
  final String category;
  Transactions(this.date, this.amount, this.description, this.category);

  Map<String, dynamic> toMap() {
    return {'date': date, 'amount': amount, 'description': description, 'category': category};
  }
}

// void addTransaction(
//     String func_date, String func_amount, String func_description) async {
//   // CollectionReference transactions =
//   //     FirebaseFirestore.instance.collection('Transaction');
//   Transaction transaction =
//       Transaction(func_date, func_amount, func_description);
//   Map<String, dynamic> transactionData = transaction.toMap();
//   await db
//       .collection("Transactions")
//       .doc("random")
//       .set(transactionData)
//       .onError((e, _) => print("Error writing document: $e"));

//   print("Added this into Transactions collection " +
//       transactionData.toString() +
//       "\n");
// }
//
// class Database {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String userCollection = "users";
//   final String noteCollection = "notes";
//   Future<void> addTransaction(
//       String func_date, String func_amount, String func_description) async {
//     try {
//       var uuid = Uuid().v4();
//       await _firestore.collection("Transactions").doc(uuid).set({
//         "date": func_date,
//         "amount": func_amount,
//         "description": func_description,
//         "creationDate": Timestamp.now(),
//       });
//     } catch (e) {
//       print("An error occured ,this is the error " + e.toString());
//     }
//   }
// }
