import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_deal_case/Services/DataProvider/discount_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/services_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/user_details_provider.dart';
import 'package:my_deal_case/View/HomePage/BuysellPage/Buy_Sell.dart';
import 'package:my_deal_case/View/HomePage/Rentalpage/Rental.dart';
import 'package:my_deal_case/View/HomePage/servicesPage/service_card_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ServicesPage extends ConsumerStatefulWidget {
  const ServicesPage({super.key});
  @override
  ConsumerState createState() => _ServicesPageState();
}

class _ServicesPageState extends ConsumerState {
  int _currentPage = 0;
  late final PageController pgController;

  List<String> pages = [
    "All",
    "HomeServices",
    "CarServices",
    "Packers and Movers",
    "Electronics Repair",
  ];
  int selectedPageIndex = -1;

  List servicesCategories = [];
  List discountData = [];
  List serviceDisData = [];

  void _fetchservices() async {
    ///use [service_details_provider] class in data provider
    try {
      await ref.read(serviceCategoryProvider.notifier).getAllServiceCategory();

      await ref.read(discountProvider.notifier).getAllDiscounts();
    } catch (e) {
      print('Error fetching discount data: $e');
      // Handle error if necessary
    }
  }

  @override
  void initState() {
    pgController = PageController(initialPage: 0, viewportFraction: 0.7);
    super.initState();
    _fetchservices();
  }

  @override
  void dispose() {
    super.dispose();
    pgController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    servicesCategories = ref.watch(serviceCategoryProvider);
    discountData = ref.watch(discountProvider);

    if (serviceDisData.isEmpty) {
      for (final item in discountData) {
        if (item["categoryType"] == "service") {
          serviceDisData.add(item);
        }
      }
    }

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15),
                height: 170,
                child: PageView.builder(
                  padEnds: false,
                  controller: pgController,
                  itemCount: serviceDisData.length,
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
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.bottomRight,
                            colors: index % 2 != 0
                                ? const [
                                    Color.fromRGBO(155, 209, 238, 1),
                                    Color.fromRGBO(181, 223, 246, 1),
                                    Color.fromRGBO(200, 230, 246, 1),
                                  ]
                                : const [
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
                                    'Get professional',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 0, bottom: 0, left: 10),
                                  child: Text(
                                    "Home Services",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "at ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        "assets/images/rupee.svg",
                                        height: 15,
                                      ),
                                      Text(
                                        "${serviceDisData[index]["flatDiscount"]}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Buy Now",
                                      style: TextStyle(
                                          color: Color.fromRGBO(232, 80, 91, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Opacity(
                                  opacity: 0.65,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    child: Transform.flip(
                                      flipX: true,
                                      child: Image.network(
                                        serviceDisData[index]['imageUrl']
                                            .toString(),
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ),
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
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    serviceDisData.length, //here give the list length
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentPage == index ? 15 : 5,
                      height: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: _currentPage == index
                            ? Colors.black
                            : Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedPageIndex = -1;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "All",
                              style: TextStyle(
                                  color: selectedPageIndex == -1
                                      ? const Color.fromRGBO(232, 80, 91, 1)
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 20,
                              height: 2,
                              color: selectedPageIndex == -1
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ...List.generate(
                      servicesCategories.length,
                      (index) {
                        return Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(
                                  top: 10, right: 10, bottom: 10, left: 15)
                              : const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedPageIndex = index;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  servicesCategories[index]["name"],
                                  style: TextStyle(
                                      color: index == selectedPageIndex
                                          ? Colors.red
                                          : Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 9 *
                                      double.parse(servicesCategories[index]
                                              ["name"]
                                          .length
                                          .toString()),
                                  height: 2,
                                  color: index == selectedPageIndex
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ]),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Popular Services',
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
                  future: getAllServices(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Skeletonizer(
                              enabled: true,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                height: 210,
                                width: 183,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.1),
                                          offset: Offset(0, 2),
                                          blurRadius: 2)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: Image.asset(
                                          "assets/images/repair.png",
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8, bottom: 0),
                                          child: Text(
                                            "Service Name",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 0, left: 8, right: 5),
                                          child: Icon(
                                              Icons.favorite_border_outlined),
                                        )
                                      ],
                                    ),
                                    const Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        "Seller Name",
                                        // "sellername",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child: Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(
                                                    244, 181, 20, 1),
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
                                              color: Color.fromRGBO(
                                                  232, 80, 91, 1),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/rupee.svg",
                                            height: 10,
                                          ),
                                          const Text(
                                            "service cost", //MARK:fix the price tag
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return ListView.builder(
                        itemCount: allServices.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ServiceCardWidget(
                            serviceDetails: allServices[index],
                          );
                        },
                      );
                    }
                  },
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Recent Service',
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
                  itemCount: 3,
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
                  height: 247,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        height: 210,
                        width: 183,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                'assets/images/1.svg',
                                height: 87,
                                width: 170,
                              ),
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 8, bottom: 0),
                                  child: Text(
                                    'AC Service',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 0, left: 8, right: 5),
                                  child: Icon(Icons.favorite_border_outlined),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                'Manoj Kumar',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
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
                            const Padding(
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
                          ],
                        ),
                      );
                    },
                  )),

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
