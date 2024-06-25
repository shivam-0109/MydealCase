import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class _ProductReviewNotifier extends StateNotifier<List> {
  _ProductReviewNotifier() : super([]);

  Future<void> getProductReview(String productId) async {
    final apiUrl =
        'http://64.227.128.230/user-reviews?filter={ "offset": 0,"limit": 100,"skip": 0,"order": "string","where": {"productId":"$productId"},"fields": {"userReviewId": true,"rating": true,"comment": true,"feedbacks": true,"customerName": true,"email": true,"mobileNumber": true,"createdAt": true,"productId": true}}';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        // print("userReview:${response.body}");
        state = responseData;
      }
    } catch (e) {
      print("cant get product Review:${e.toString()}");
    }
  }
}

final productReviewProvider =
    StateNotifierProvider<_ProductReviewNotifier, List>(
  (ref) => _ProductReviewNotifier(),
);
