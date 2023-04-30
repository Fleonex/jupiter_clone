import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jupiter_clone/screens/Dashboard/components/transactionlist.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';
import 'package:jupiter_clone/screens/Dashboard/components/transaction.dart';
import 'package:jupiter_clone/excelsheet.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();

  const Dashboard({
    Key? key,
  }) : super(key: key);
}

List<Widget> AllWidgets = [
  Text('Widget 1'),
  Text('Widget 2'),
  Text('Widget 3'),
  // ...
];

class _DashboardState extends State<Dashboard> {
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: softBlue,
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: const BoxDecoration(
                color: purple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 24,
                  right: 24,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/user_photo.png', height: 50),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                        const Spacer(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset('assets/icons/ic_bell.png',
                                  height: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Expenses',
                              style: subTitle,
                            ),
                            Text(
                              '\$12,500,000',
                              style: largePrimary,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Column(
            //     children: [ListView.builder(
            //       itemCount: AllWidgets.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return ListTile(
            //           title: Text(AllWidgets[index].toString()),
            //         );
            //       },
            //     )]
            // )
            // ,
            const SizedBox(
              height: 20,
            ),
            TransactionList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Transaction()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),

      ),
    );
  }
}
