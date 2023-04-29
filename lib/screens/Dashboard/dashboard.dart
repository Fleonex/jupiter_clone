import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';
import 'package:jupiter_clone/components/navbar.dart';
import 'package:jupiter_clone/screens/Dashboard/transaction.dart';

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
      // appBar: AppBar(
      //   title: Text('My App'),
      // ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                color: purple,
                borderRadius: BorderRadius.only(
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
                              icon:
                              Image.asset('assets/icons/ic_bell.png', height: 20),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // children: [
                    //   Text(
                    //     'Transactions',
                    //     style: subHeader,
                    //   ),
                    //   SizedBox(
                    //     height: 10,
                    //   ),
                    //   Row(
                    //     children: [
                    //       Image.asset(
                    //         'assets/icons/ic_apple.png',
                    //         height: 50,
                    //       ),
                    //       SizedBox(
                    //         width: 12,
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             'Apple',
                    //             style: mainHeader,
                    //           ),
                    //           Text(
                    //             'AirPod Pro 3',
                    //             style: paragraph,
                    //           ),
                    //         ],
                    //       ),
                    //       Spacer(),
                    //       Text(
                    //         '+\$5,320',
                    //         style: labelBluePrimary,
                    //       ),
                    //     ],
                    //   ),
                    //   SizedBox(
                    //     height: 14,
                    //   ),
                    //
                    // ],
                    children: [
                      Transaction(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
