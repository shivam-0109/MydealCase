import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/DataProvider/discount_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/order_detail_provider.dart';

class ApplyCoupon extends ConsumerStatefulWidget {
  @override
  ConsumerState<ApplyCoupon> createState() => _ApplyCouponState();
}

class _ApplyCouponState extends ConsumerState<ApplyCoupon> {
  List? discounts;
  late Map<String, dynamic> currentProductDetails;
  @override
  void initState() {
    getAllDiscountsHere();
    currentProductDetails = ref.read(currentOrderProvider);
    super.initState();
  }

  void getAllDiscountsHere() async {
    await ref.read(discountProvider.notifier).getAllDiscounts();
  }

  @override
  Widget build(BuildContext context) {
    discounts = ref.watch(discountProvider);
    List applicable = [];
    List notApplicable = [];

    if (discounts != null && discounts!.isNotEmpty) {
      for (final item in discounts!) {
        if (item["categoryId"] == currentProductDetails["categoryId"]) {
          applicable.add(item);
        } else {
          notApplicable.add(item);
        }
      }
      setState(() {});
    }
    print(applicable);
    print(notApplicable);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Apply Coupon',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 323,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromRGBO(245, 245, 245, 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                          decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        hintText: 'Search...',
                        enabledBorder: InputBorder.none,
                        suffixIcon: const Icon(
                          Icons.search_outlined,
                          color: Color.fromRGBO(164, 164, 164, 1),
                        ),
                        hintStyle: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(164, 164, 164, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset('assets/images/filter.svg'),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Card(
                color: const Color.fromRGBO(255, 255, 255, 1),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Applicable',
                          style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ...List.generate(applicable.length, (index) {
                          return buildApplicableDiscountInfo(
                              applicable[index]["code"],
                              applicable[index]["discountPercentage"],
                              applicable[index]["flatDiscount"],
                              applicable[index],
                              ref,
                              context);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Not Applicable',
                              style: GoogleFonts.montserrat(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ...List.generate(notApplicable.length, (index) {
                              return buildNotApplicableDiscountInfo(
                                  notApplicable[index]["code"],
                                  notApplicable[index]["discountPercentage"],
                                  notApplicable[index]["flatDiscount"]);
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildApplicableDiscountInfo(
    String code,
    int percentage,
    int flatDiscount,
    Map<String, dynamic> details,
    WidgetRef ref,
    BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            code,
            style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(width: 40),
          Text(
            'You will save ${percentage.toString()}%',
            style: GoogleFonts.montserrat(
              color: Color.fromRGBO(0, 195, 125, 1),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
      SizedBox(height: 15),
      // Text(
      //   'Extra Upto 25% on Rs.2589',
      //   style: GoogleFonts.montserrat(
      //     color: const Color.fromRGBO(0, 0, 0, 1),
      //     fontWeight: FontWeight.w400,
      //     fontSize: 12,
      //   ),
      // ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'flat discount ${flatDiscount.toString()}',
            style: GoogleFonts.montserrat(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          InkWell(
            onTap: () {
              ref
                  .read(selectedDiscountCouponProvider.notifier)
                  .setCurrentCoupon(details);
              Navigator.pushReplacementNamed(context, "CheckoutScreen");
            },
            child: Text(
              'Apply Coupon',
              style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(232, 80, 91, 1),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 15),
      Text(
        'View T&C',
        style: GoogleFonts.montserrat(
          color: const Color.fromRGBO(232, 80, 91, 1),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      SizedBox(
        height: 15,
      )
    ],
  );
}

Widget buildNotApplicableDiscountInfo(
    String code, int percentage, int flatDiscount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        code,
        style: GoogleFonts.montserrat(
          color: const Color.fromRGBO(22, 22, 22, 0.3),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      SizedBox(height: 15),
      Text(
        'You will save ${percentage.toString()}%',
        style: GoogleFonts.montserrat(
          color: const Color.fromRGBO(22, 22, 22, 0.3),
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
      Text(
        'flat discount ${flatDiscount.toString()}',
        style: GoogleFonts.montserrat(
          color: const Color.fromRGBO(22, 22, 22, 0.3),
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
      SizedBox(height: 15),
      Text(
        'View T&C',
        style: GoogleFonts.montserrat(
          color: const Color.fromRGBO(232, 80, 91, 0.4),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      SizedBox(
        height: 7,
      ),
    ],
  );
}
