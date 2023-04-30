import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jupiter_clone/style/color.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _amountController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
    final TextEditingController _dateController = TextEditingController();

    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    void _submitData() {
      final String enteredAmount = _amountController.text;
      final String enteredDescription = _descriptionController.text;

      if (enteredAmount.isEmpty || enteredDescription.isEmpty) {
        return;
      }
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      final DateTime enteredDate = dateFormat.parse(_dateController.text);

      Navigator.of(context).pop();
    }

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
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter amount';
                }
                return null;
              },
              onSaved: (String? value) {
                _amountController.text = value!;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
              onSaved: (String? value) {
                _descriptionController.text = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Date',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter date';
                }
                return null;
              },
              keyboardType: TextInputType.datetime,
              onTap: () async {
                DateTime? date = DateTime(1900);

                date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(DateTime.now().year + 1));

                    _dateController.text = DateFormat('yyyy-MM-dd').format(date!);
              }
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _submitData();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
