import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/DataProvider/order_detail_provider.dart';
import 'package:my_deal_case/Services/DataProvider/product_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/product_review_provider..dart';
import 'package:my_deal_case/Services/DataProvider/similer_product_provider.dart';
import 'package:my_deal_case/Services/HomeServices/BuySellService.dart';
import 'package:my_deal_case/View/HomePage/ProductDetails/review_details_widget.dart';
import 'package:my_deal_case/View/HomePage/chatPage/ChatScreen.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsBuySell extends ConsumerStatefulWidget {
  const ProductDetailsBuySell({super.key});
  @override
  ConsumerState createState() => _ProductState();
}

class _ProductState extends ConsumerState {
  int _currentPage = 0;
  late final PageController pgController;
  late String productId;
  late Map<String, dynamic> productDetails;
  List productReviews = [];
  List similerProduct = [];
  int genaratedRiviewListCount = 2;
  @override
  void initState() {
    pgController = PageController(initialPage: 0);

    productId = ref.read(productIdProvider);
    productDetails = ref.read(productDetailsProvider);
    loadUserReview(productId);
    // getCurrentProductDetails();
    super.initState();
  }

  void loadUserReview(String productId) async {
    await ref.read(productReviewProvider.notifier).getProductReview(productId);
    await ref
        .read(similerProductProvider.notifier)
        .getSimilerProduct(productTypeId: productDetails["productTypeId"]);
  }

  @override
  void dispose() {
    super.dispose();
    pgController.dispose();
  }

  Map<String, double> data = {
    'Shopping': 65,
    'Review': 35,
  };

  @override
  Widget build(BuildContext context) {
    productReviews = ref.watch(productReviewProvider);
    similerProduct = ref.watch(similerProductProvider);
    final size = MediaQuery.of(context).size;
    print(productReviews);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/images/back.svg')),
          Padding(
            padding: const EdgeInsets.only(right: 100, left: 20),
            child: Text(
              'Product Details',
              style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset('assets/images/shear.svg'),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset('assets/images/shoping.svg'),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: SizedBox(
              height: 240,
              width: 0,
              child: PageView.builder(
                controller: pgController,
                itemCount: productDetails["images"].length,
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
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(0),
                            height: 240,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(231, 231, 231, 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                productDetails == {}
                                    ? Skeletonizer(
                                        enabled: true,
                                        child: SvgPicture.asset(
                                          'assets/images/laptop.svg',
                                          height: 153,
                                          width: 255,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          productDetails["images"][index],
                                          fit: BoxFit.cover,
                                          height: 240,
                                          width: double.infinity,
                                        ),
                                      ),

                                /// change hard coded 0 to index
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 30,
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    print("favorite");

                                    /// have to add favorite screen functionality
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 0, top: 30),
                                    child: Icon(
                                      Icons.favorite_border,
                                      size: 25,
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: productDetails["images"].length == 1
                                        ? 135
                                        : 115,
                                    top: 35),
                                child: SizedBox(
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: List.generate(
                                      productDetails["images"]
                                          .length, //here give the list length
                                      (index) => AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        width: _currentPage == index ? 10 : 8,
                                        height: 8,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
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
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // ENd The PageView
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productDetails["name"],
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/rupee.svg",
                            height: 12,
                          ),
                          Text(
                            productDetails["price"].toString(),
                            style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 2, bottom: 30),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 22,
                      color: Color.fromRGBO(255, 214, 0, 1),
                    ),
                    Text(
                      '4.5',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '(100+ Reviews)',
                        style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(136, 136, 136, 1),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //End the Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 92,
                width: 52,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromRGBO(236, 236, 236, 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/images/cloud.svg',
                          height: 12,
                          width: 12,
                        ),
                      ),
                    ),
                    Text(
                      'Processor',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(192, 192, 192, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      productDetails["specifications"][
                          productDetails["productType"]["specifications"][1]
                              ["identifier"]],
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 92,
                width: 52,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromRGBO(236, 236, 236, 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/images/memory.svg',
                          height: 12,
                          width: 12,
                        ),
                      ),
                    ),
                    Text(
                      'System',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(192, 192, 192, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      productDetails["specifications"][
                          productDetails["productType"]["specifications"][0]
                              ["identifier"]],
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 92,
                width: 52,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromRGBO(236, 236, 236, 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/images/graphics.svg',
                          height: 12,
                          width: 12,
                        ),
                      ),
                    ),
                    Text(
                      'Graphics',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(192, 192, 192, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      productDetails["specifications"][
                          productDetails["productType"]["specifications"][2]
                              ["identifier"]],
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 92,
                width: 52,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromRGBO(236, 236, 236, 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/images/sd.svg',
                          height: 12,
                          width: 12,
                        ),
                      ),
                    ),
                    Text(
                      'Memory',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(192, 192, 192, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      productDetails["specifications"][
                          productDetails["productType"]["specifications"][3]
                              ["identifier"]],
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 92,
                width: 52,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromRGBO(236, 236, 236, 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/images/processor.svg',
                          height: 12,
                          width: 12,
                        ),
                      ),
                    ),
                    Text(
                      'Storage',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(192, 192, 192, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      productDetails["specifications"][
                          productDetails["productType"]["specifications"][4]
                              ["identifier"]],
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Text(
              'DESCRIPTION',
              style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              productDetails == {}
                  ? const Skeletonizer(
                      enabled: true, child: Text("description"))
                  : productDetails!["description"],
              style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(106, 106, 106, 1),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Text(
              'EXCLUSIVE OFFERS',
              style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '. Doorstep Demo',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(106, 106, 106, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '. Offers & Discounts',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(106, 106, 106, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '. Lowest EMI       ',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(106, 106, 106, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '. Exchange Benefit',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(106, 106, 106, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 30, bottom: 40),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: const Color.fromRGBO(232, 80, 91, 1)),
                      ),
                      child: Text(
                        'Get The Best Deal',
                        style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(232, 80, 91, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 0, top: 0, bottom: 10),
            child: Text(
              'Compare With Similar Laptops',
              style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          ///MARK:compare start here
          SizedBox(
            height: 220,
            child: similerProduct.isEmpty
                ? Container(
                    height: 180,
                    alignment: Alignment.center,
                    child: const Text(
                      "No similar product",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: similerProduct.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          ref
                              .read(productIdProvider.notifier)
                              .setProductId(similerProduct[index]["productId"]);

                          ref
                              .read(productDetailsProvider.notifier)
                              .setProductDetails(
                                similerProduct[index],
                              );

                          Navigator.pushNamed(
                            context,
                            "ProductDetails",
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(0),
                          height: 200,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(223, 223, 223, 1)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                ),
                                child: Image.network(
                                  similerProduct[index]["images"][0],
                                  height: 60,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  similerProduct[index]["name"],
                                  style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Rs. ${similerProduct[index]["price"]}",
                                  style: GoogleFonts.montserrat(
                                    color:
                                        const Color.fromRGBO(106, 106, 106, 1),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'onwards',
                                  style: GoogleFonts.montserrat(
                                    color:
                                        const Color.fromRGBO(162, 162, 162, 1),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text('Intel'),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          ///MARK:compare end here
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(30),
            height: 60,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: const Color.fromRGBO(206, 206, 206, 1))),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(11),
                      child: SvgPicture.asset('assets/images/headphone.svg'),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get in touch',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 15,
                          color: Color.fromRGBO(232, 80, 91, 1),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'call now',
                          style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(232, 80, 91, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Text(
              "${productDetails["name"]} review",
              style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Color.fromRGBO(255, 214, 0, 1),
                ),
                Text(
                  '4.5',
                  style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '(100+ Reviews)|60 Ratings',
                  style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(136, 136, 136, 1),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 125,
            width: 357,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(223, 223, 223, 1),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          PieChart(
                            dataMap: data,
                            emptyColor: const Color.fromRGBO(223, 223, 223, 1),
                            colorList: const [
                              Color.fromRGBO(232, 80, 91, 1),
                              Color.fromRGBO(223, 223, 223, 1),
                            ],
                            chartType: ChartType.ring,
                            ringStrokeWidth: 3,
                            chartRadius: 30,
                            centerWidget: Text(
                              '4.7',
                              style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            legendOptions: const LegendOptions(
                              showLegends: false,
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValues: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0, right: 50),
                            child: Text(
                              'Exterior',
                              style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          PieChart(
                            dataMap: data,
                            emptyColor: const Color.fromRGBO(223, 223, 223, 1),
                            colorList: const [
                              Color.fromRGBO(232, 80, 91, 1),
                              Color.fromRGBO(223, 223, 223, 1),
                            ],
                            chartType: ChartType.ring,
                            ringStrokeWidth: 3,
                            chartRadius: 30,
                            centerWidget: Text(
                              '4.7',
                              style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            legendOptions: const LegendOptions(
                              showLegends: false,
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValues: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0, right: 50),
                            child: Text(
                              'Display',
                              style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(
              color: const Color.fromRGBO(223, 223, 223, 1),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  productReviews.isEmpty
                      ? 'All Reviews (0)'
                      : 'All Reviews (${productReviews.length})',
                  style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Latest',
                  style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          if (productReviews.isEmpty)
            Container(
              height: 50,
              child: const Text(
                "No Reviews Yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
            )
          else
            ...List.generate(
              genaratedRiviewListCount,
              (index) {
                return ReviewDetailsWidget(
                  productReviewDetail: productReviews[index],
                  productName: productDetails["name"],
                );
              },
            ),

          Visibility(
            visible: productReviews.isEmpty ? false : true,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 40,
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Read All Reviews",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
                onTap: () {},
                child: SvgPicture.asset('assets/images/more.svg')),
            InkWell(
                onTap: () {},
                child: SvgPicture.asset('assets/images/favIcon.svg')),
            Container(
              alignment: Alignment.center,
              height: 55,
              width: 166,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(44, 42, 42, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  ref
                      .read(currentOrderProvider.notifier)
                      .getCurrentProductDetails(productDetails);
                  Navigator.pushNamed(context, 'CheckoutScreen');
                },
                child: Text(
                  'Buy Now',
                  style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
