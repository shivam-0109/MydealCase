import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_deal_case/Services/DataProvider/product_details_provider.dart';

class PrommotionWidget extends ConsumerStatefulWidget {
  const PrommotionWidget({super.key, required this.promotionsDetails});
  final Map<String, dynamic> promotionsDetails;

  @override
  ConsumerState<PrommotionWidget> createState() => _PrommotionWidgetState();
}

class _PrommotionWidgetState extends ConsumerState<PrommotionWidget> {
  Map<String, dynamic> productDetails = {};
  @override
  void initState() {
    super.initState();
    loadProductDetails();
  }

  void loadProductDetails() async {
    await ref
        .read(getProductByIdProvider.notifier)
        .getProductById(widget.promotionsDetails["productId"]);
  }

  @override
  Widget build(BuildContext context) {
    productDetails = ref.watch(getProductByIdProvider);

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
                child: Image.network(
                  widget.promotionsDetails["imageUrl"],
                  height: 130,
                  width: 155,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 5),
              child: Text(
                widget.promotionsDetails["title"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              productDetails == {}
                  ? "product special"
                  : productDetails["specifications"][
                      "${productDetails["productType"]["specifications"][4]["identifier"]}"],
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '₹ ${int.parse((widget.promotionsDetails["product"]["price"] - ((productDetails["price"] * productDetails["discountPercentage"]) / 100)).round().toString())}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),
                  Text(
                    '₹ ${widget.promotionsDetails["product"]["price"]}',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Color.fromRGBO(170, 169, 169, 1),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
