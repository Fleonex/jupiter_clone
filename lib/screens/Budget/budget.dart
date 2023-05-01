import 'package:flutter/material.dart';
import 'package:jupiter_clone/style/color.dart';

class BudgetingPage extends StatefulWidget {
  const BudgetingPage({Key? key}) : super(key: key);

  @override
  _BudgetingPageState createState() => _BudgetingPageState();
}

class _BudgetingPageState extends State<BudgetingPage> {
  // Default budget values
  double _foodBudget = 500.0;
  double _housingBudget = 1000.0;
  double _transportBudget = 300.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budgeting'),
        backgroundColor: purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Set your monthly budget for each category:',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16.0),
            _buildCategoryBudgetRow('Food', _foodBudget, (value) {
              setState(() {
                _foodBudget = value as double;
              });
            }),
            SizedBox(
              height: 10.0,
            ),
            _buildCategoryBudgetRow('Housing', _housingBudget, (value) {
              setState(() {
                _housingBudget = value as double;
              });
            }),
            SizedBox(
              height: 10.0,
            ),
            _buildCategoryBudgetRow('Transport', _transportBudget, (value) {
              setState(() {
                _transportBudget = value as double;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBudgetRow(String category, double budget, Function(String) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(category),
        Row(
          children: [
            Text('\Rs.'),
            SizedBox(
              width: 100.0,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: budget.toStringAsFixed(2)),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
