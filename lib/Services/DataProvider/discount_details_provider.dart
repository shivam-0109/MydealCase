import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class _DiscountDetailsNotifier extends StateNotifier<List> {
  _DiscountDetailsNotifier() : super([]);

  Future<void> getAllDiscounts() async {
    const url =
        'http://64.227.128.230/discount-vouchers?filter ={ "offset": 0,"limit": 100,"skip": 0,"order": "string","where": {},"fields": {"discountVoucherId": true,"code": true,"couponType": true,"validity": true,"discountPercentage": true,"validFrom": true,"validTo": true,"imageUrl": true,"categoryType": true,"status": true,"flatDiscount": true,"createdAt": true,"categoryId": true }}';
    final urlParse = Uri.parse(url);
    try {
      final response = await http.get(urlParse);
      print(response.body);
      state = json.decode(response.body);
    } catch (e) {
      print("discount:${e.toString()}");
    }
  }

  Future<void> getSelectedDiscounts(String type) async {
    final url =
        'http://64.227.128.230/discount-vouchers?filter ={"where":{categoryType:product} }';
    final urlParse = Uri.parse(url);
    try {
      final response = await http.get(urlParse);
      print(response.body);
      state = json.decode(response.body);
    } catch (e) {
      print("discount:${e.toString()}");
    }
  }
}

final discountProvider = StateNotifierProvider<_DiscountDetailsNotifier, List>(
  (ref) => _DiscountDetailsNotifier(),
);

class _SelectedDiscountCouponNotifier
    extends StateNotifier<Map<String, dynamic>> {
  _SelectedDiscountCouponNotifier() : super({});

  void setCurrentCoupon(Map<String, dynamic> details) {
    state = details;
    print(state);
  }

  void emptyCoupon() {
    state = {};
  }
}

final selectedDiscountCouponProvider = StateNotifierProvider<
    _SelectedDiscountCouponNotifier, Map<String, dynamic>>(
  (ref) => _SelectedDiscountCouponNotifier(),
);
