import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_deal_case/Services/DataProvider/brands_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/order_detail_provider.dart';

import 'package:my_deal_case/Services/DataProvider/promotion_details_provider.dart';
import 'package:my_deal_case/View/HomePage/BuysellPage/brand_page.dart';
import 'package:my_deal_case/View/HomePage/BuysellPage/promotion_widget.dart';

import 'package:my_deal_case/Services/DataProvider/discount_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/product_details_provider.dart';
import 'package:my_deal_case/Services/HomeServices/BuySellService.dart';
import 'package:my_deal_case/View/HomePage/BuysellPage/product_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:skeletonizer/skeletonizer.dart';

class BuySell extends ConsumerStatefulWidget {
  const BuySell({super.key});
  @override
  ConsumerState createState() => _BuySellState();
}

class _BuySellState extends ConsumerState {
  int _currentPage = 0;
  late final PageController pgController;
  int selectedPageIndex = -1;
  List buySellData = [];
  Map<String, dynamic>? userDetails;
  @override
  void initState() {
    pgController = PageController(initialPage: 0, viewportFraction: 0.7);
    super.initState();

    _fetchproduct();
  }

  @override
  void dispose() {
    super.dispose();
    pgController.dispose();
  }

  List<dynamic> _product = [];
  List<dynamic> _discountData = []; // Initialize list to hold discount data
  List<dynamic> _selectedProduct = [];

  void _fetchproduct() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      // Call your ApiService method to fetch discount data
      await ref.read(allProductProvider.notifier).getAllProduct();
      await ref.read(discountProvider.notifier).getSelectedDiscounts("product");
      userDetails = json.decode(prefs.getString("userData")!);
      // Update state with fetched data
    } catch (e) {
      print('Error fetching discount data: $e');
      // Handle error if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    _discountData = ref.watch(discountProvider);
    _product = ref.watch(allProductProvider);
    // _selectedProduct = ref.watch(getSelectedProductProvider);

    if (buySellData.isEmpty) {
      for (final item in _discountData) {
        if (item["categoryType"] == "product") {
          buySellData.add(item);
        }
      }
    }

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15),
                alignment: Alignment.centerRight,
                height: 170,
                child: PageView.builder(
                  padEnds: false,
                  controller: pgController,
                  itemCount: buySellData.length,
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
                            right: 10, top: 10, left: 0, bottom: 4),
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
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              bottom: 5,
                              child: Image.network(
                                buySellData[index]['imageUrl'].toString(),
                                fit: BoxFit.cover,
                                height: 100,
                                width: 150,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 0, left: 10),
                                  child: Text(
                                    ' ${buySellData[index]['discountPercentage'].toString()}% Off', // Update text with fetched discount
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 0,
                                  ),
                                  child: Text(
                                    'On ${buySellData[index]['categoryType'].toString()} today', // Update description with fetched data
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 15, right: 15, bottom: 10),
                                  child: Text(
                                    'with code: ${buySellData[index]['code']}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ), // Update code with fetched data
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
                    buySellData.length, //here give the list length
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
                      padding: const EdgeInsets.only(left: 20, bottom: 10),
                      child: InkWell(
                        onTap: () {
                          ref.read(allProductProvider.notifier).getAllProduct();
                          setState(() {
                            selectedPageIndex = -1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, top: 3),
                          child: Column(
                            children: [
                              Text(
                                'All',
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
                    ),
                    SizedBox(
                      height: 30,
                      width: 370,
                      child: FutureBuilder(
                        future: categoryApi(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return const Skeletonizer(
                                      child: Row(
                                    children: [
                                      Text(
                                        'Electronics',
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ));
                                },
                              ),
                            );
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: postList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    ref
                                        .read(allProductProvider.notifier)
                                        .getSelectedProduct(
                                            postList[index]["categoryId"]);

                                    setState(() {
                                      selectedPageIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: index == postList.length - 1
                                        ? const EdgeInsets.only(
                                            right: 60, left: 5)
                                        : const EdgeInsets.symmetric(
                                            horizontal: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          postList[index]!["name"],
                                          style: TextStyle(
                                              color: index == selectedPageIndex
                                                  ? Colors.red
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          width: 9 *
                                              double.parse(
                                                  postList[index]!["name"]
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
                            );
                          }
                        },
                      ),
                    )
                  ]),
                ),
              ),

              // 1st ListView builder
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Todays Deals!',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 206, 199),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const Text(
                        '04:53:10',
                        style: TextStyle(
                            color: Color.fromRGBO(232, 80, 91, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'See More',
                        style: TextStyle(
                            color: Color.fromRGBO(232, 80, 91, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 255,
                width: double.infinity,
                child: _product.isEmpty
                    ? const SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Text(
                            "Oops look like nothing is on deal today",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.red),
                          ),
                        ),
                      )
                    : FutureBuilder(
                        future: productApi(), // api call
                        builder: (context, index) {
                          if (!index.hasData) {
                            return SizedBox(
                              height: 350,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Skeletonizer(
                                    child: Container(
                                      margin: const EdgeInsets.all(20),
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
                                              Text('(36 Reviews)')
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
                            return ProductListWidget(
                                ctx: context, productDetails: _product);
                          }
                        }),
              ),
              //end
              // 2 listView builder
              const Padding(
                padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      'New Arrivals!',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'See More',
                        style: TextStyle(
                            color: Color.fromRGBO(232, 80, 91, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              ProductListWidget(
                ctx: context,
                productDetails: _product,
              ),

              // Top Brands
              //ListV 3
              const Padding(
                padding: EdgeInsets.all(20.0),
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
                child: FutureBuilder(
                  future: getTopBrands(brandType: "product"),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // itemCount: 3,
                        itemBuilder: (context, index) {
                          return Skeletonizer(
                            enabled: true,
                            child: Column(
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
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  ref
                                      .read(selectedBrandProvider.notifier)
                                      .getSelectedBrand(snapshot.data![index]);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const BrandPage(),
                                  ));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color.fromARGB(
                                          255, 200, 200, 200),
                                      radius: 42,
                                      child: Image.network(
                                        snapshot.data![index]["imageUrl"],
                                        height: 60,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('${snapshot.data![index]["name"]}'),
                                    //end brands and list viewBuilder
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
              //4 ListV Sponsored start
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    const Text(
                      'Sponsored',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.red,
                          ),
                        ),
                        child: const Text(
                          'AD',
                          style: TextStyle(
                              color: Color.fromRGBO(232, 80, 91, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 247,
                width: double.infinity,
                child: FutureBuilder(
                  future: getPromotions(),
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
                              height: 247,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 130,
                                    width: 155,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/images/pc.png',
                                        height: 130,
                                        width: 155,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, left: 8, right: 8, bottom: 5),
                                    child: Text(
                                      'Apple MacBook',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Mac OS",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            color: Color.fromRGBO(
                                                170, 169, 169, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: promotions.length,
                        itemBuilder: (context, index) {
                          return PrommotionWidget(
                            promotionsDetails: promotions[index],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              // end Sponsored
              //5 ListV Recently Viewed start
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      'Recently Purchesed',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'see More',
                        style: TextStyle(
                            color: Color.fromRGBO(232, 80, 91, 1),
                            fontWeight: FontWeight.w900,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: SizedBox(
                  height: 247,
                  width: double.infinity,
                  child: FutureBuilder(
                    future: getUserOrderDetails(userDetails!["userId"]),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          //  itemCount: 3,
                          itemBuilder: (context, index) {
                            return Skeletonizer(
                              enabled: true,
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
                                            child: Text(
                                                'Apple MacBook Pro 16 inch'),
                                          )),
                                          Padding(
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
                                  )),
                            );
                          },
                        );
                      } else if (snapshot.data!.isEmpty) {
                        return Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: const Center(
                            child: Text("Please order something"),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          ///MARK:pending
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
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
                                  Image.network(
                                    snapshot.data![index]["product"]["images"]
                                        [0],
                                    height: 123,
                                    width: 155,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data![index]["product"]
                                                ["name"],
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '₹ ${(snapshot.data![index]["product"]["price"] - ((snapshot.data![index]["product"]["price"] * snapshot.data![index]["product"]["discountPercentage"]) / 100)).round()}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "₹ ${snapshot.data![index]["product"]["price"]}"
                                              .toString(),
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            color: Color.fromRGBO(
                                                170, 169, 169, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              // end Recently
            ],
          ),
        ),
      ),
    );
  }
}
