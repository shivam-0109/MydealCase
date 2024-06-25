import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_deal_case/Services/DataProvider/brands_details_provider.dart';
import 'package:my_deal_case/View/HomePage/searchBarPage/searched_element_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BrandPage extends ConsumerStatefulWidget {
  const BrandPage({super.key});
  @override
  ConsumerState<BrandPage> createState() {
    return _BrandPageState();
  }
}

class _BrandPageState extends ConsumerState<BrandPage> {
  late Map<String, dynamic> brandDetails;
  int selectedPageIndex = -1;

  @override
  void initState() {
    brandDetails = ref.read(selectedBrandProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${brandDetails["name"]}"),
      ),
      body: Column(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: InkWell(
                    onTap: () {
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
                    future:
                        getBrandCateGoryDetails(brandDetails["categoryList"]),
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
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedPageIndex = index;
                                });
                              },
                              child: Padding(
                                padding: index == snapshot.data!.length - 1
                                    ? const EdgeInsets.only(right: 60, left: 5)
                                    : const EdgeInsets.symmetric(
                                        horizontal: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data![index]!["name"],
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
                                          double.parse(snapshot
                                              .data![index]!["name"].length
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
          FutureBuilder(
            future: selectedPageIndex == -1
                ? getBradedProduct(brandDetails["name"])
                : getBradedProductWithCategory(brandDetails["name"],
                    brandedCategories[selectedPageIndex]["categoryId"]),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Skeletonizer(
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(152, 158, 158, 158),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/images/laptop.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        "product Name",
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
                                        const Text(
                                          "Product price",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text("|",
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              )),
                                        ),
                                        const Text(
                                          "100 pieces left",
                                          style: TextStyle(
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
                    },
                  ),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Product not found",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return SearchedElementWidget(
                        productDetails: snapshot.data![index],
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
