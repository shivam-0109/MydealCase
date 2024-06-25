import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_deal_case/Services/DataProvider/product_details_provider.dart';

class SearchedElementWidget extends ConsumerWidget {
  const SearchedElementWidget({super.key, required this.productDetails});
  final Map<String, dynamic> productDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(productDetails);
    return InkWell(
      onTap: () {
        ref
            .read(productIdProvider.notifier)
            .setProductId(productDetails["productId"]);

        ref.read(productDetailsProvider.notifier).setProductDetails(
              productDetails,
            );

        Navigator.pushNamed(
          context,
          "ProductDetails",
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(152, 158, 158, 158),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  productDetails["images"][0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      productDetails["name"],
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/rupee.svg",
                        color: Colors.grey,
                        height: 13,
                      ),
                      Text(
                        productDetails["price"].toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("|",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            )),
                      ),
                      Text(
                        "${productDetails["stockItemCount"]} pieces left",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
