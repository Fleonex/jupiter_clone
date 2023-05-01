import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jupiter_clone/services/auth.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';
import '../Settings/Settings.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';
import 'package:jupiter_clone/category.dart';
import 'package:jupiter_clone/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jupiter_clone/services/database.dart';
import 'package:jupiter_clone/style/color.dart';
import '../../models/transactions.dart';
import '../../style/constants.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DatabaseService _db = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
  void _pickFile() async {
    String filePath;
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
            String gotCategory = "";
            if(rowList[3] == ""){
              gotCategory = "Food";
              // gotCategory =  await getCategory(["transportation","food","beauty"], rowList[2]);
              print("The category of this " + rowList[2].toString() +" "+ gotCategory + "\n");
            }
            else{
              gotCategory = rowList[3].toString();
            }
            final String enteredAmount = rowList[1].toString();
            final String enteredDescription = rowList[2].toString();
            final String selectedCategory = gotCategory;
            DateFormat dateFormat = DateFormat("yyyy-MM-dd");
            final DateTime enteredDate = dateFormat.parse(rowList[0].toString().substring(0,10));
            Transactions newTransaction = Transactions(enteredDate, double.parse(enteredAmount), enteredDescription, selectedCategory!);

            await  _db.addTransaction(newTransaction);
            // if (res != null) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(
            //       content: Text('Transaction added successfully'),
            //     ),
            //   );
            //   Navigator.of(context).pop();
            // } else {
            //   if (mounted) {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //         content: Text('Error adding transaction'),
            //       ),
            //     );
            //   }
            // }
            // await Database().addTransaction(rowList[0], rowList[1], rowList[2]);
            rows.add(rowList);
          } else {
            first = false;
          }
        }
      }
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softBlue,
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: const BoxDecoration(
                    color: purple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 24,
                      right: 24,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/user_photo.png',
                                height: 150),
                            const SizedBox(
                              width: 6,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Howdy',
                                  style: subTitle,
                                ),
                                Text(
                                  'Kang Smile',
                                  style: headerWhite,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 70,
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                        _pickFile();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.newspaper, color: red, size: 30),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Upload Excel Sheet',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 24,
                  right: 24,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.settings, color: red, size: 30),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Settings',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              AuthService().signOut();
            },
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 24,
                  right: 24,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.power_settings_new, color: red, size: 30),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Sign Out',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
