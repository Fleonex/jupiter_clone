import 'package:flutter/material.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:provider/provider.dart';
import 'package:jupiter_clone/screens/Settings/currencymodel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedCurrency = 'INR';
  String _selectedDateFormat = 'MM/dd/yyyy';
  String _selectedLanguage = 'English';

  List<String> _currencies = ['USD', 'EUR', 'INR'];
  List<String> _dateFormats = ['MM/dd/yyyy', 'dd/MM/yyyy', 'yyyy/MM/dd'];
  List<String> _languages = ['English', 'Spanish', 'French', 'German'];

  @override
  Widget build(BuildContext context) {
    _selectedCurrency = currencyModel.currenctCurrency;
    return Provider(
        create: (_) => currencyModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
            backgroundColor: purple,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Currency',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _selectedCurrency,
                  decoration: const InputDecoration(
                    // labelText: 'Select currency',
                    prefixIcon: Icon(Icons.monetization_on),
                  ),
                  items: _currencies
                      .map((currency) => DropdownMenuItem<String>(
                            value: currency,
                            child: Text(currency),
                          ))
                      .toList(),
                  onChanged: (value) {
                    Provider.of<currencyModel>(context, listen: false)
                        .changeCurrency(value!);
                    setState(() {
                      _selectedCurrency = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Date format',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _selectedDateFormat,
                  decoration: const InputDecoration(
                    // labelText: 'Select date format',
                    prefixIcon: Icon(Icons.date_range),
                  ),
                  items: _dateFormats
                      .map((dateFormat) => DropdownMenuItem<String>(
                            value: dateFormat,
                            child: Text(dateFormat),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDateFormat = value!;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _selectedLanguage,
                  decoration: const InputDecoration(
                    // labelText: 'Select language',
                    prefixIcon: Icon(Icons.language),
                  ),
                  items: _languages
                      .map((language) => DropdownMenuItem<String>(
                            value: language,
                            child: Text(language),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
