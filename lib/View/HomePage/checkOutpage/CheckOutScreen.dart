import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/DataProvider/discount_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/order_detail_provider.dart';
import 'package:my_deal_case/Services/DataProvider/product_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/services_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/user_details_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum OrderStatus {
  product_order_recived,
  product_sent,
  product_arrived,
  delivery_done
}

class CheckoutScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  late Map<String, dynamic> producDetails;
  late Map<String, dynamic> serviceDetails;
  Map<String, dynamic>? userdetails;
  Map<String, dynamic>? usedCouponDetails;
  Map<String, dynamic>? sellerDetails;
  Map<String, String>? serviceTime;
  List? userAddress;
  @override
  void initState() {
    producDetails = ref.read(currentOrderProvider);
    serviceDetails = ref.read(selectedServiceProvider);
    serviceTime = ref.read(selectedDateAndTimeProvider);
    getUserDetails();
    super.initState();
  }

  void getUserDetails() async {
    final pref = await SharedPreferences.getInstance();
    userdetails = json.decode(pref.getString("userData")!);
    await ref
        .read(allUserProvider.notifier)
        .getAlluserAddress(userdetails!["userId"]);
  }

  @override
  Widget build(BuildContext context) {
    String idType = producDetails.keys.firstOrNull!;
    print(idType);

    userAddress = ref.watch(allUserProvider);
    usedCouponDetails = ref.watch(selectedDiscountCouponProvider);
    Map defaultAddress = {};
    if (userAddress!.isNotEmpty && userAddress != null) {
      for (final item in userAddress!) {
        if (item["isDefault"] == true) {
          defaultAddress = item;
        }
      }
      setState(() {});
    }
    print(producDetails);

    double couponDiscount = 0.0;
    double normalDiscount = 0.0;
    double productPrice = 0.0;
    double finalAmount = 0.0;

    if (producDetails.isNotEmpty) {
      if (idType == "serviceId") {
        ///MArk:do the service details
        couponDiscount = usedCouponDetails == null || usedCouponDetails!.isEmpty
            ? 0
            : (((producDetails["serviceCost"] *
                    usedCouponDetails!["discountPercentage"]) /
                100));

        normalDiscount = ((producDetails["serviceCost"] *
                producDetails["discountPercentage"]) /
            100);
        productPrice = double.parse(producDetails["serviceCost"].toString());
        finalAmount = (productPrice - (couponDiscount + normalDiscount));
      } else if (idType == "productId") {
        couponDiscount = usedCouponDetails == null || usedCouponDetails!.isEmpty
            ? 0
            : (((producDetails["price"] *
                    usedCouponDetails!["discountPercentage"]) /
                100));

        normalDiscount =
            ((producDetails["price"] * producDetails["discountPercentage"]) /
                100);

        productPrice = double.parse(producDetails["price"].toString());
        finalAmount = (productPrice - (couponDiscount + normalDiscount));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Checkout',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Card(
                color: const Color.fromRGBO(255, 255, 255, 1),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected product',
                        style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromRGBO(245, 245, 245, 1),
                            ),
                            child: Center(
                              /// MARK:Fix the image part for service
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: idType == "productId"
                                    ? Image.network(producDetails["images"][0])
                                    : idType == "serviceId"
                                        ? Text("fix")
                                        : null, // Replace with your CircleAvatar or image
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  idType == "productId"
                                      ? producDetails["fullName"]
                                      : idType == "serviceId"
                                          ? "seller name"

                                          ///MARK:it should be seller name
                                          : "rental",
                                  style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(232, 80, 91, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  idType == "productId"
                                      ? producDetails["fullName"]
                                      : idType == "serviceId"
                                          ? producDetails["name"]
                                          : "rental",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/rupee.svg",
                                height: 11,
                              ),
                              Text(
                                productPrice.toString(),
                                style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(232, 80, 91, 1),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: const Color.fromRGBO(232, 80, 91, 1),
                            size: 17,
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          Skeletonizer(
                            enabled: defaultAddress == {},
                            child: Text(
                              '${defaultAddress["address"]},${defaultAddress["city"]}',
                              style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(92, 92, 92, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.punch_clock,
                            color: const Color.fromRGBO(232, 80, 91, 1),
                            size: 17,
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          Text(
                            idType == "serviceId"
                                ? serviceTime!["time"]!
                                : "3:00",
                            style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(92, 92, 92, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Card(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  elevation: 2,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            usedCouponDetails == null ||
                                    usedCouponDetails!.isEmpty
                                ? 'Apply Coupon'
                                : usedCouponDetails!["code"],
                            // "code",
                            style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'ApplyCoupon');
                            },
                            child: Text(
                              usedCouponDetails == null ||
                                      usedCouponDetails!.isEmpty
                                  ? 'Select'
                                  : "change",
                              style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(232, 80, 91, 1),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ))),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Card(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  elevation: 2,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Summary',
                            style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Coupon Discount',
                                style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/rupee.svg",
                                    height: 10,
                                  ),
                                  Text(
                                    couponDiscount.toString(),
                                    style: GoogleFonts.montserrat(
                                      color:
                                          const Color.fromRGBO(82, 180, 107, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Discount',
                                style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/rupee.svg",
                                    height: 10,
                                  ),
                                  Text(
                                    normalDiscount.toString(),
                                    style: GoogleFonts.montserrat(
                                      color:
                                          const Color.fromRGBO(82, 180, 107, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       'Convenience Fee',
                          //       style: GoogleFonts.montserrat(
                          //         color: const Color.fromRGBO(0, 0, 0, 1),
                          //         fontWeight: FontWeight.w400,
                          //         fontSize: 12,
                          //       ),
                          //     ),
                          //     Text(
                          //       '\$ 500',
                          //       style: GoogleFonts.montserrat(
                          //         color: const Color.fromRGBO(0, 0, 0, 1),
                          //         fontWeight: FontWeight.w400,
                          //         fontSize: 12,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Grand Total',
                                style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/rupee.svg",
                                    height: 10,
                                  ),
                                  Text(
                                    finalAmount.toString(),
                                    style: GoogleFonts.montserrat(
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 195, 125,
                                  0.2), // You can change the color as needed
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Hurray, you have saved ${productPrice - (productPrice - (couponDiscount + normalDiscount))} rupees !!',
                                style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(0, 195, 125, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                        ],
                      ))),
            )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          bool done = false;
          if (idType == "productId") {
            done = await ref.read(confirmOrderProvider.notifier).placeOrder(
                  productName: producDetails["name"],
                  productPrice: productPrice.toString(),
                  customerName: userdetails!["fullName"],
                  email: userdetails!["email"],
                  mobileNumber: userdetails!["mobileNumber"],
                  city: defaultAddress["city"],
                  orderType: producDetails["sellType"],
                  address: defaultAddress["address"],
                  pincode: defaultAddress["pincode"],
                  discountPercentage: producDetails["discountPercentage"],
                  finalAmount: finalAmount.round(),
                  amountPaid: finalAmount.round(),
                  amountPending: 0,
                  status: "product-order-recived",
                  subCategoryId: producDetails["subCategoryId"],
                  userId: userdetails!["userId"],
                  categoryId: producDetails["categoryId"],
                  productId: producDetails["productId"],
                  promotionalAdsId: "",
                  discountVoucherId:
                      usedCouponDetails == null || usedCouponDetails!.isEmpty
                          ? ""
                          : usedCouponDetails!["discountVoucherId"],
                );
          } else if (idType == "serviceId") {
            done = await ref.read(confirmOrderProvider.notifier).orderService(
                customerName: userdetails!["fullName"],
                mobileNumber: userdetails!["mobileNumber"],
                pincode: defaultAddress["pincode"].toString(),
                address: defaultAddress["address"],
                city: defaultAddress["city"],
                pstate: defaultAddress["state"],
                serviceDate: serviceTime!["date"]!,
                slot: serviceTime!["time"]!,
                paidAmount: finalAmount.round(),
                pendingAmount: 0,
                totalAmount: finalAmount.round(),
                status: "service-order-recived",
                userId: userdetails!["userId"],
                categoryId: producDetails["categoryId"],
                subCategoryId: producDetails["subCategoryId"],
                serviceId: producDetails["serviceId"]);
          }

          ref.read(selectedDiscountCouponProvider.notifier).emptyCoupon();
          print(done);
          if (done == true) {
            Navigator.pushReplacementNamed(context, 'Payment');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Something went wrong please try again later"),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40, left: 50, right: 50),
          child: Container(
            alignment: Alignment.center,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(44, 42, 42, 1),
            ),
            child: Text(
              'Pay Now',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
