import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'package:jupiter_clone/models/transactions.dart';

class uploadFile extends StatefulWidget {
  const uploadFile({Key? key}) : super(key: key);

  @override
  State<uploadFile> createState() => _uploadFileState();
}
class _uploadFileState extends State<uploadFile> {
  List<List<dynamic>> _data = [];
  String? filePath;
  // This function is triggered when the  button is pressed
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.white,
            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          title: const Text("Bulk Upload",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              )),
        ),
        body: Column(
          children: [
            ElevatedButton(
              child: const Text("Upload FIle"),
              onPressed: () {
                _pickFile();
              },
            ),
            ElevatedButton(
              child: const Text("Populate Data"),
              onPressed: () {
                _pickFile();
              },
            ),
          ],
        ));
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    print("This is the name of the file you picked!" + result.files.first.name);

    filePath = result.files.first.path!;
    if (filePath != null) {
      var bytes = File(filePath.toString()).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      List<List<String>> rows = [];
      for (var table in excel.tables.keys) {
        print(table); //sheet Name
        print(excel.tables[table]!.maxCols);
        print(excel.tables[table]!.maxRows);
        bool first = true;
        for (var row in excel.tables[table]!.rows) {
          List<String> rowList = [];
          for (var cell in row) {
            rowList.add(cell!.value.toString());
          }
          if (!first) {
            // await Database().addTransaction(rowList[0], rowList[1], rowList[2]);
            rows.add(rowList);
          } else {
            first = false;
          }
          // print("The value of each row" + rows.last.toString());
        }
        setState(() {
          _data = rows;
        });
      }
    }
  }
}
