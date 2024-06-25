import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/DataProvider/product_details_provider.dart';
import 'package:my_deal_case/View/AdManager/add_product_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productDetails});

  final Map<String, dynamic> productDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        fontSize: 16,
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
            const Spacer(),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )),
          ],
        ));
  }
}

class ProductList extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProductList> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  Map<String, dynamic>? userDetails;
  List<dynamic> userProducts = [];
  @override
  void initState() {
    loadDetails();
    super.initState();
  }

  void loadDetails() async {
    final prefs = await SharedPreferences.getInstance();
    userDetails = json.decode(prefs.getString("userData")!);

    ref
        .read(productOfUserProvider.notifier)
        .getUserProduct(userDetails!["userId"]);
  }

  @override
  Widget build(BuildContext context) {
    userProducts = ref.watch(productOfUserProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Product List',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddProductWidget(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_box_outlined,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.search,
                        color: Color.fromRGBO(164, 164, 164, 1),
                        size: 15,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color.fromRGBO(245, 245, 245, 1),
                  contentPadding: const EdgeInsets.only(top: 10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(164, 164, 164, 1),
                  ),
                ),
                cursorColor: Colors.grey,
              ),
              const SizedBox(height: 16),
              userProducts.isEmpty
                  ? const Center(
                      child: Text(
                        "Please add product",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,

                      itemCount:
                          userProducts.length, // Number of items in the list
                      itemBuilder: (context, index) {
                        return ProductItem(
                          productDetails: userProducts[index],
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
