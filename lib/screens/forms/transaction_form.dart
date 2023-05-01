import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jupiter_clone/services/database.dart';
import 'package:jupiter_clone/style/color.dart';

import '../../models/transactions.dart';
import '../../style/constants.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DatabaseService _db = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
  final TextEditingController amountController = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();
  final TextEditingController descriptionController =
  TextEditingController();

  final TextEditingController dateController = TextEditingController();
  String? _selectedCategory = 'Food'; // default category

  List<String> _categories = [];
  bool isNewCategoryEnabled = true;
  String newCategory='';

  @override
  void initState(){
    super.initState();
     _fetchData();
  }

  Future _fetchData() async{
    List<Map<String, dynamic>>? catList = await _db.getCategories();
    List<String> categoriesList = [];
    if (catList == null) {
      return;
    }

    for (int i = 0; i < catList.length; i++) {
      categoriesList.add(catList[i]['category']);
    }

    setState(() {
      _categories = categoriesList;
    });
  }

  void _submitData() {
    final String enteredAmount = amountController.text;
    final String enteredDescription = descriptionController.text;


    String selectedCategory = _selectedCategory!; // default category value
    if (isNewCategoryEnabled) {
      newCategory = newCategoryController.text;
      if (newCategory.isNotEmpty) {
        selectedCategory = newCategory;
      }
    }
    if (enteredAmount.isEmpty || enteredDescription.isEmpty || _selectedCategory == null) {
      return;
    }

    if (_selectedCategory == "None") {
      selectedCategory = "Others";
    }
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final DateTime enteredDate = dateFormat.parse(dateController.text);

    Transactions newTransaction = Transactions(enteredDate, double.parse(enteredAmount), enteredDescription, selectedCategory);

    final Future? res = _db.addTransaction(newTransaction);

    if (res != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaction added successfully'),
        ),
      );
      Navigator.of(context).pop();
    } else {
      if (!mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error adding transaction'),
          ),
        );
      }
    }
  }
  void showNewCategoryDialog() async {
    final categoryName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New category'),
        content: TextField(
          controller: newCategoryController,
          decoration: InputDecoration(
            hintText: 'Enter category name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, newCategoryController.text.trim());
            },
            child: Text('Save'),
          ),
        ],
      ),
    );

    if (categoryName != null && categoryName.isNotEmpty) {
      setState(() {
        _categories.add(categoryName);
        _selectedCategory = categoryName;
      });
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
                    dateController.text = DateFormat("yyyy-MM-dd").format(value);
                  }
                });
              },
            ),
            const SizedBox(height: 10.0 ),
            (_categories.isEmpty) ? Container() :
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.category),
                ),
              ),
              items: [
                for (var category in _categories)
                  DropdownMenuItem(
                    value: category,
                    child: Text(category)
                  ),
                DropdownMenuItem(
                  value: newCategory,
                  child: Row(
                    children: const [
                      Icon(Icons.add, color: lightPurple),
                      SizedBox(width: 8),
                      Text('New category', style: TextStyle(color: darkGray)),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                  if (_selectedCategory == newCategory) {
                    // Prompt the user to enter a new category
                    showNewCategoryDialog();
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a category';
                }
                return null;
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
