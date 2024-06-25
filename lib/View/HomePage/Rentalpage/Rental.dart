import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_deal_case/View/HomePage/BuysellPage/Buy_Sell.dart';
import 'package:my_deal_case/View/HomePage/servicesPage/Services.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({super.key});
  @override
  State createState() => _RentalPageState();
}

class _RentalPageState extends State {
  int _currentPage = 0;
  late final PageController pgController;
  @override
  void initState() {
    pgController = PageController(initialPage: 0, viewportFraction: 0.90);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pgController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 22),
                        child: Text(
                          'All',
                          style: TextStyle(
                              color: Color.fromRGBO(232, 80, 91, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Electronics',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Appliences',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Furniture',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Vehicles',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                    ]),
              ),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Newest Listing',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'See More',
                        style: TextStyle(
                            color: Color.fromRGBO(232, 80, 91, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 270,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  //   itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.all(10),
                        height: 247,
                        width: 171,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  offset: Offset(0, 2),
                                  blurRadius: 2)
                            ]),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/images/1.svg',
                              height: 123,
                              width: 155,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Apple MacBook Pro 16 inch'),
                                )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 15, left: 8, right: 5),
                                  child: Icon(Icons.favorite_border_outlined),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Icon(
                                        Icons.star,
                                        color: Color.fromRGBO(244, 181, 20, 1),
                                        size: 15,
                                      )),
                                  Text('4.8'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '(87 Reviews)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: Color.fromRGBO(232, 80, 91, 1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    '₹ 1350/month',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                Text(
                                  '₹ 1,20,000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Color.fromRGBO(170, 169, 169, 1),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ));
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Recommended for you',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'See More',
                        style: TextStyle(
                            color: Color.fromRGBO(232, 80, 91, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 270,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  //  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.all(10),
                        height: 247,
                        width: 171,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  offset: Offset(0, 2),
                                  blurRadius: 2)
                            ]),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/images/1.svg',
                              height: 123,
                              width: 155,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Apple MacBook Pro 16 inch'),
                                )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 15, left: 8, right: 5),
                                  child: Icon(Icons.favorite_border_outlined),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Icon(
                                        Icons.star,
                                        color: Color.fromRGBO(244, 181, 20, 1),
                                        size: 15,
                                      )),
                                  Text('4.8'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '(87 Reviews)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: Color.fromRGBO(232, 80, 91, 1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    '₹ 1350/month',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                Text(
                                  '₹ 1,20,000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Color.fromRGBO(170, 169, 169, 1),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ));
                  },
                ),
              ),
              //Container
              Container(
                margin: const EdgeInsets.all(10),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 72, 1, 1),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        offset: Offset(0, 2),
                        blurRadius: 2,
                      )
                    ]),
              ),

              //Start Brands
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Top Brands',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'See More',
                        style: TextStyle(
                            color: Color.fromRGBO(232, 80, 91, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              // 2 ListV end brands List viewBuilder start
              SizedBox(
                height: 150,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 85,
                          width: 85,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: const Text('SAMSUNG'),
                        ),
                        const Text('SAMSUNG'),

                        //end brands and list viewBuilder
                      ],
                    );
                  },
                ),
              ),

              //Start Sponsored
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Sponsored',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Ad',
                        style: TextStyle(
                            color: Color.fromRGBO(232, 80, 91, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 270,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.all(10),
                        height: 247,
                        width: 171,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  offset: Offset(0, 2),
                                  blurRadius: 2)
                            ]),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/images/1.svg',
                              height: 123,
                              width: 155,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Apple MacBook Pro 16 inch'),
                                )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 15, left: 8, right: 5),
                                  child: Icon(Icons.favorite_border_outlined),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Icon(
                                        Icons.star,
                                        color: Color.fromRGBO(244, 181, 20, 1),
                                        size: 15,
                                      )),
                                  Text('4.8'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '(87 Reviews)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: Color.fromRGBO(232, 80, 91, 1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    '₹ 1350/month',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                Text(
                                  '₹ 1,20,000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Color.fromRGBO(170, 169, 169, 1),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ));
                  },
                ),
              ),

              // ListView
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Recently Viewed',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'see More',
                        style: TextStyle(
                            color: Color.fromRGBO(232, 80, 91, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 270,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.all(10),
                        height: 247,
                        width: 171,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  offset: Offset(0, 2),
                                  blurRadius: 2)
                            ]),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/images/1.svg',
                              height: 123,
                              width: 155,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Apple MacBook Pro 16 inch'),
                                )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 15, left: 8, right: 5),
                                  child: Icon(Icons.favorite_border_outlined),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Icon(
                                        Icons.star,
                                        color: Color.fromRGBO(244, 181, 20, 1),
                                        size: 15,
                                      )),
                                  Text('4.8'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '(87 Reviews)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: Color.fromRGBO(232, 80, 91, 1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    '₹ 1350/month',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                Text(
                                  '₹ 1,20,000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Color.fromRGBO(170, 169, 169, 1),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ));
                  },
                ),
              ),
              // End Recently

              // Start end container
              Container(
                margin: const EdgeInsets.all(10),
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 190, 203, 14),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        offset: Offset(0, 2),
                        blurRadius: 2,
                      )
                    ]),
              ),
              // end the ad container
            ],
          ),
        ),
      ),
    );
  }
}
