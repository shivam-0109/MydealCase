import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_deal_case/Services/DataProvider/services_details_provider.dart';

class ServiceCardWidget extends ConsumerWidget {
  const ServiceCardWidget({
    super.key,
    required this.serviceDetails,
  });
  final Map<String, dynamic> serviceDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref
            .read(selectedServiceProvider.notifier)
            .getSelectedService(serviceDetails);
        Navigator.pushNamed(context, 'HomeServiceScreen');
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 210,
        width: 183,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset(0, 2),
                  blurRadius: 2)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  serviceDetails["images"][0],
                  fit: BoxFit.cover,
                  height: 100,
                  width: double.infinity,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 0),
                  child: Text(
                    serviceDetails["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(bottom: 0, left: 8, right: 5),
                  child: Icon(Icons.favorite_border_outlined),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                serviceDetails["user"]["fullName"],
                // "sellername",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Icon(
                        Icons.star,
                        color: Color.fromRGBO(244, 181, 20, 1),
                        size: 15,
                      )),
                  Text('4.8'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '(87 Reviews)',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Color.fromRGBO(232, 80, 91, 1),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/rupee.svg",
                    height: 10,
                  ),
                  Text(
                    serviceDetails["serviceCost"]
                        .toString(), //MARK:fix the price tag
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color.fromRGBO(0, 0, 0, 1),
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
