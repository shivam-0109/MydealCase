import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_deal_case/Services/DataProvider/product_details_provider.dart';
import 'package:my_deal_case/Services/DataProvider/product_review_provider..dart';

class ReviewDetailsWidget extends ConsumerStatefulWidget {
  const ReviewDetailsWidget(
      {super.key,
      required this.productReviewDetail,
      required this.productName});
  final Map<String, dynamic> productReviewDetail;
  final String productName;
  @override
  ConsumerState<ReviewDetailsWidget> createState() {
    return _ReviewDetailsWidgetState();
  }
}

class _ReviewDetailsWidgetState extends ConsumerState<ReviewDetailsWidget> {
  int reviewDays = 0;

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    int starCount = double.parse(widget.productReviewDetail["rating"]).round();
    int reviewYear = int.parse(
        widget.productReviewDetail["createdAt"].toString().substring(0, 4));
    int reviewMonth = int.parse(
        widget.productReviewDetail["createdAt"].toString().substring(5, 7));
    int reviewDayCount = int.parse(
        widget.productReviewDetail["createdAt"].toString().substring(8, 10));

    if (date.year == reviewYear) {
      if (date.month == reviewMonth) {
        setState(() {
          reviewDays = date.day - reviewDayCount;
        });
      } else if (date.month > reviewMonth) {
        int temp = date.day - reviewDayCount;
        if (temp < 0) {
          setState(() {
            reviewDays = (30 - temp);
          });
        } else {
          setState(() {
            reviewDays = temp;
          });
        }
      }
    }

    print("riviewMonth:$reviewMonth");
    print("riviewDayCount:$reviewDayCount");
    print("riviewYear$reviewYear");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 2),
          child: Text(
            widget.productName,
            style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
          child: Row(
            children: [
              ...List.generate(
                starCount,
                (index) {
                  return const Icon(
                    Icons.star,
                    color: Color.fromRGBO(255, 214, 0, 1),
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 23),
          child: Text(
            date.year > reviewYear
                ? '${date.year - reviewYear} year ago| ${widget.productReviewDetail["customerName"]}'
                : '$reviewDays days ago| ${widget.productReviewDetail["customerName"]}',
            style: const TextStyle(
              color: const Color.fromRGBO(136, 136, 136, 1),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            widget.productReviewDetail["comment"],
            style: const TextStyle(
              color: Color.fromRGBO(106, 106, 106, 1),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Padding(
          padding: const EdgeInsets.only(left: 23),
          child: Row(
            children: [
              Text(
                'Was this review helpful?',
                style: const TextStyle(
                  color: const Color.fromRGBO(136, 136, 136, 1),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Icon(
                Icons.thumb_up_alt_outlined,
                color: Color.fromRGBO(152, 152, 152, 1),
                size: 16,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Icon(
                  Icons.thumb_down_alt_outlined,
                  color: Color.fromRGBO(152, 152, 152, 1),
                  size: 16,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
