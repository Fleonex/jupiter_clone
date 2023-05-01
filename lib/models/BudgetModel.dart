import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
class BudgetCategory {
  String name;
  double limit;
  double currentAmount;

  BudgetCategory(this.name, this.limit, this.currentAmount);

  void checkBudget() {
    if (currentAmount > limit) {
      // Send notification to user
    }
  }
  Map<String, dynamic> toMap() {
    return {'name': name, 'limit': limit, 'currentAmount': currentAmount};
  }

}
