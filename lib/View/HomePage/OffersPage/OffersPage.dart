import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/HomeServices/BuySellService.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});
  @override
  State createState() => _OffersPage();
}

class _OffersPage extends State {
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
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(19),
            child: SvgPicture.asset(
              'assets/images/back.svg',
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Offers',
          style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: pgController,
                  itemCount: 5,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: pgController,
                      builder: (context, child) {
                        return child!;
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 20, top: 10, left: 0, bottom: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.15),
                              offset: Offset(0, 2),
                              blurRadius: 11,
                            )
                          ],
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(255, 156, 142, 1),
                              Color.fromRGBO(251, 181, 171, 1),
                              Color.fromRGBO(255, 218, 213, 1),
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 0, left: 10),
                                  child: Text(
                                    '70% off',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 8, bottom: 15),
                                  child: Text(
                                    'on everything today',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text('with code:FSCREATION'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Buy Now'),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 50),
                                child: Image.asset(
                                  'assets/images/acOffer.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5, //here give the list length
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentPage == index ? 10 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.black
                            : Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              // 1st ListView builder
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Best Deals!',
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
                  height: 247,
                  width: double.infinity,
                  child: FutureBuilder(
                      future: productApi(), // api call
                      builder: (context, index) {
                        if (!index.hasData) {
                          return SizedBox(
                            height: 238,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Skeletonizer(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    height: 238,
                                    width: 169,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 123,
                                          width: 155,
                                          color: Colors.black,
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    'Apple Macbook pro 16 inch')),
                                            Icon(Icons.favorite),
                                          ],
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.star),
                                            Text('(35 Reviews)')
                                          ],
                                        ),
                                        const Text('1350')
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount:
                                productList.length, //api data store in list
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              log(productList[index].name.toString());
                              // api data access the help of list
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'ProductDetails');
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 247,
                                  width: 171,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.1),
                                            offset: Offset(0, 2),
                                            blurRadius: 2)
                                      ]),
                                  child: Column(
                                    children: [
                                      Image.network(
                                          productList[index]
                                              .images
                                              .first
                                              .toString(),
                                          height: 123,
                                          width: 155),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(productList[index]
                                                .name
                                                .toString()),
                                          )),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 15, left: 8, right: 5),
                                            child: Icon(
                                                Icons.favorite_border_outlined),
                                          )
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '₹ 83,000',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '₹ 1,20,000',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              color: Color.fromRGBO(
                                                  170, 169, 169, 1),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      })),
              //end
              // 2 listView builder
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Daily Deals!',
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
                height: 247,
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
                            Image.asset(
                              'assets/images/pc.png',
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
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    '₹ 83,000',
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
              // Advertise container
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
              //End Container
              // Top Brands
              //ListV 3
              // end Recently
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Best Deals!',
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
                  height: 247,
                  width: double.infinity,
                  child: FutureBuilder(
                      future: productApi(), // api call
                      builder: (context, index) {
                        if (!index.hasData) {
                          return SizedBox(
                            height: 238,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Skeletonizer(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    height: 238,
                                    width: 169,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 123,
                                          width: 155,
                                          color: Colors.black,
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    'Apple Macbook pro 16 inch')),
                                            Icon(Icons.favorite),
                                          ],
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.star),
                                            Text('(35 Reviews)')
                                          ],
                                        ),
                                        const Text('1350')
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount:
                                productList.length, //api data store in list
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              log(productList[index].name.toString());
                              // api data access the help of list
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'ProductDetails');
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 247,
                                  width: 171,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.1),
                                            offset: Offset(0, 2),
                                            blurRadius: 2)
                                      ]),
                                  child: Column(
                                    children: [
                                      Image.network(
                                          productList[index]
                                              .images
                                              .first
                                              .toString(),
                                          height: 123,
                                          width: 155),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(productList[index]
                                                .name
                                                .toString()),
                                          )),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 15, left: 8, right: 5),
                                            child: Icon(
                                                Icons.favorite_border_outlined),
                                          )
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '₹ 83,000',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '₹ 1,20,000',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              color: Color.fromRGBO(
                                                  170, 169, 169, 1),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      })),

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
