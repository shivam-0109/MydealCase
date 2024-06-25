import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_deal_case/Services/DataProvider/search_product_provider.dart';
import 'package:my_deal_case/View/HomePage/searchBarPage/searched_element_widget.dart';

class SearchBarPage extends ConsumerStatefulWidget {
  const SearchBarPage({super.key});
  @override
  ConsumerState createState() => _Search();
}

class _Search extends ConsumerState {
  TextEditingController searchBarController = TextEditingController();
  List searchedProducts = [];
  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    searchedProducts = ref.watch(searchedProductProvider);
    print("sercherdProductHere:$searchedProducts");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              ref.read(searchedProductProvider.notifier).setEmpty();
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: SvgPicture.asset(
                'assets/images/back.svg',
                height: 20,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromRGBO(245, 245, 245, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Form(
                  key: fromKey,
                  child: TextFormField(
                    controller: searchBarController,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      hintText: 'Search',
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
                    ),
                    onFieldSubmitted: (value) {
                      print("search");
                      print(searchBarController.text);
                      if (searchBarController.text.isNotEmpty) {
                        ref
                            .read(searchedProductProvider.notifier)
                            .getSearchedProduct(value!);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: searchedProducts.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Recently Searches',
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Clear All',
                          style: GoogleFonts.montserrat(
                              color: const Color.fromRGBO(232, 80, 91, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: 31,
                          width: 77,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 206, 199, 1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Laptop',
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              SvgPicture.asset('assets/images/remove.svg')
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: 31,
                          width: 141,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 206, 199, 1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Washing Machine',
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              SvgPicture.asset('assets/images/remove.svg')
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 31,
                        width: 77,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: const Color.fromRGBO(255, 206, 199, 1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Laptop',
                              style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            SvgPicture.asset('assets/images/remove.svg')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: 31,
                          width: 83,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 206, 199, 1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sofa Set',
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              SvgPicture.asset('assets/images/remove.svg')
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: 31,
                          width: 66,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 206, 199, 1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'chair',
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              SvgPicture.asset('assets/images/remove.svg')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 8),
                  child: Text(
                    'Popular Searches',
                    style: GoogleFonts.montserrat(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: 31,
                          width: 77,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 206, 199, 1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Laptop',
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              SvgPicture.asset('assets/images/graph.svg')
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: 31,
                          width: 141,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 206, 199, 1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Washing Machine',
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              SvgPicture.asset('assets/images/graph.svg')
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 31,
                        width: 77,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: const Color.fromRGBO(255, 206, 199, 1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Laptop',
                              style: GoogleFonts.montserrat(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            SvgPicture.asset('assets/images/graph.svg')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: 31,
                          width: 83,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 206, 199, 1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sofa Set',
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              SvgPicture.asset('assets/images/graph.svg')
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: 31,
                          width: 66,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 206, 199, 1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'chair',
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              SvgPicture.asset('assets/images/graph.svg')
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          height: 31,
                          width: 66,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 206, 199, 1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'AC',
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              SvgPicture.asset('assets/images/graph.svg')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: searchedProducts.length,
              itemBuilder: (context, index) {
                return SearchedElementWidget(
                    productDetails: searchedProducts[index]);
              },
            ),
    );
  }
}
