import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jupiter_clone/services/database.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/category.dart';
import '../../models/transactions.dart';
import '../../style/constants.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DatabaseService _db =
      DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

  final TextEditingController amountController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  void _submitData() async {
    final String enteredAmount = amountController.text;
    final String enteredDescription = descriptionController.text;
    String enteredCategory = categoryController.text;

    if (enteredAmount.isEmpty || enteredDescription.isEmpty) {
      return;
    }
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final DateTime enteredDate = dateFormat.parse(dateController.text);
    List<String> CandidateLabels = [];
    String sequenceToClassify = enteredDescription;
    if (enteredCategory == "") {
      enteredCategory = await getCategory(CandidateLabels, sequenceToClassify);
    }
    Transactions newTransaction = Transactions(enteredDate,
        double.parse(enteredAmount), enteredDescription, enteredCategory);

    final Future? res = _db.addTransaction(newTransaction);

    if (res != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaction added successfully'),
        ),
      );
      Navigator.of(context).pop();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error adding transaction'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        backgroundColor: purple,
        actions: [
          IconButton(
            onPressed: () {
              _submitData();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(height: 10.0),
            TextFormField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.attach_money),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter amount';
                }

                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onSaved: (String? value) {
                amountController.text = value!;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.description),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
              onSaved: (String? value) {
                descriptionController.text = value!;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Date',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.calendar_today),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter date';
                }
                return null;
              },
              keyboardType: TextInputType.datetime,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((DateTime? value) {
                  if (value != null) {
                    dateController.text =
                        DateFormat("yyyy-MM-dd").format(value);
                  }
                });
              },
            ),
            const SizedBox(height: 10.0),
            Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    _submitData();
                  }
                },
                child: Text(
                  "Submit".toUpperCase(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
