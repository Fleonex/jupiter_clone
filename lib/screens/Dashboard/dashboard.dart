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
      bottomNavigationBar: Container(
        // add border radius to only top side
        decoration: BoxDecoration(
            color: black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12)
            )

        ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),

            child: GNav(
                backgroundColor: black,
                color: white,
                activeColor: white,
                tabBackgroundColor: Colors.grey.shade900,
                gap: 3,
                padding: EdgeInsets.all(16),
                tabs: const[
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.graphic_eq,
                    text: 'Graphs',
                  ),
                  GButton(
                    icon: Icons.money,
                    text: 'Budget',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ]
            ),
          ),
      ),

      backgroundColor: softBlue,
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                color: purple,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 60,
                  left: 24,
                  right: 24,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/user_photo.png', height: 50),
                        SizedBox(
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
                        Spacer(),
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
                    SizedBox(
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
            SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 300,
            //   child: SingleChildScrollView(
            //     child: Column(children: [
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Transaction(),
            //     ]),
            //   ),
            // ),
            TransactionList(),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: white,
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(30),
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(24.0),
            //       child: Column(
            //         children: [
            //           Transaction(),
            //           // Transaction(),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: white,
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(30),
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(24.0),
            //       child: Column(
            //         children: [
            //           Transaction(),
            //           // Transaction(),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Transaction()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),

      ),
    );
  }
}
