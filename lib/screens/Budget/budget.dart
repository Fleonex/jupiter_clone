import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_clone/services/database.dart';

import '../../style/color.dart';

class BudgetingPage extends StatefulWidget {
  const BudgetingPage({Key? key}) : super(key: key);

  @override
  _BudgetingPageState createState() => _BudgetingPageState();
}

class _BudgetingPageState extends State<BudgetingPage> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  List<Widget> _categoryLimit = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final res = await DatabaseService(uid: uid).getCategories();

    List<_Categories> categories = [];
    if (res == null) {
      // print(res);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error fetching data'),
        ),
      );
    }

    setState(() {
      // print(res);
      for(var data in res!) {
        categories.add(_Categories(data['category'], data['limit']));
        // print(data);
      }
    });

    for (var category in categories) {
      _categoryLimit.add(_buildCategoryBudgetRow(category.name, category.budget, (value) {
        DatabaseService(uid: uid).updateCategory(category.name, double.parse(value));
        setState(() {
          category.budget = double.parse(value);
        });
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgeting'),
        backgroundColor: purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Set your monthly budget for each category:'),
            const SizedBox(height: 16.0),
            ..._categoryLimit,
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBudgetRow(
      String category, double budget, Function(String) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(category),
        Row(
          children: [
            const Text('Rs.'),
            SizedBox(
              width: 100.0,
              child: TextField(
                keyboardType: TextInputType.number,
                controller:
                    TextEditingController(text: budget.toStringAsFixed(2)),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Categories {
  String name;
  double budget;

  _Categories(this.name, this.budget);
}
