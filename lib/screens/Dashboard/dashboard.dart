import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jupiter_clone/style/color.dart';
import 'package:jupiter_clone/style/typo.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();

  const Dashboard({
    Key? key,
  }) : super(key: key);
}

class _DashboardState extends State<Dashboard> {

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
       gap: 3,
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


      backgroundColor: softBlue,
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                color: black,
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
                              'Balance',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transactions',
                        style: subHeader,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_apple.png',
                            height: 50,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Apple',
                                style: mainHeader,
                              ),
                              Text(
                                'AirPod Pro 3',
                                style: paragraph,
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            '-\$5,320',
                            style: labelRedPrimary,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_bwa.png',
                            height: 50,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'BWA Class',
                                style: mainHeader,
                              ),
                              Text(
                                'Scholarship',
                                style: paragraph,
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            '+\$500,000',
                            style: labelBluePrimary,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_dji.png',
                            height: 50,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DJI',
                                style: mainHeader,
                              ),
                              Text(
                                'Mavic Pro',
                                style: paragraph,
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            '-\$900,210',
                            style: labelRedPrimary,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_sbux.png',
                            height: 50,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Starbucks',
                                style: mainHeader,
                              ),
                              Text(
                                'Cocoa Oatmilk',
                                style: paragraph,
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            '-\$72,000',
                            style: labelRedPrimary,
                          ),
                        ],
                      ),
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
