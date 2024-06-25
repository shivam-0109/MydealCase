import 'package:flutter/material.dart';

class MyAdsCardWidget extends StatefulWidget {
  const MyAdsCardWidget({super.key, required this.promotionsDetails});
  final Map<String, dynamic> promotionsDetails;
  @override
  State<MyAdsCardWidget> createState() {
    return _MyAdsCardWidgetState();
  }
}

class _MyAdsCardWidgetState extends State<MyAdsCardWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.promotionsDetails);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Card(
        color: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Active',
                    style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromRGBO(245, 245, 245, 1),
                        ),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.network(widget.promotionsDetails[
                                "imageUrl"]), // Replace with your CircleAvatar or image
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.promotionsDetails["title"],
                        style: const TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cost Per Click',
                            style: TextStyle(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'INR ${widget.promotionsDetails["costPerClick"]}',
                            style: const TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Amount Spend',
                        style: TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'INR ${widget.promotionsDetails["amountSpend"]}',
                        style: const TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Link Clicks',
                        style: TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.promotionsDetails["views"].toString(),
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          alignment: Alignment.center,
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green[400],
                          ),
                          child: const Text(
                            'Boost Ad',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
