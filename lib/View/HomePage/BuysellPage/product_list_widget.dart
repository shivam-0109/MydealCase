import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_deal_case/Services/DataProvider/product_details_provider.dart';
import 'package:my_deal_case/Services/HomeServices/BuySellService.dart';

class ProductListWidget extends ConsumerWidget {
  const ProductListWidget(
      {super.key, required this.ctx, required this.productDetails});
  final BuildContext ctx;
  final List productDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(ctx).size;
    print("productWidget:$productDetails");

    return Container(
      height: 255, //MARK:change this thing
      // width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productDetails.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.only(
                  top: 10, right: 10, bottom: 10, left: 15),
              width: (size.width - 30) / 2,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        offset: Offset(0, 2),
                        blurRadius: 2)
                  ]),
              child: GestureDetector(
                onTap: () async {
                  ref
                      .read(productIdProvider.notifier)
                      .setProductId(productDetails[index]["productId"]);

                  ref.read(productDetailsProvider.notifier).setProductDetails(
                        productDetails[index],
                      );

                  Navigator.pushNamed(
                    context,
                    "ProductDetails",
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          productDetails[index]["images"][0],
                          fit: BoxFit.cover,
                          height: 123,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              productDetails[index]["name"],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(bottom: 15, left: 15, right: 5),
                          child: Icon(Icons.favorite_border_outlined),
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/rupee.svg",
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                productDetails[index]["price"].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                            ),
                            const Text(
                              '₹ 1,20,000',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color.fromRGBO(170, 169, 169, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5, left: 12, bottom: 10),
                      child: Text(
                        'EMI Availiable',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
