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
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("Upload File"),
      onPressed: () {

      },
    );
  }


}
