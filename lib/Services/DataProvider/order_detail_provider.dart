import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _CurrentOrderNotifier extends StateNotifier<Map<String, dynamic>> {
  _CurrentOrderNotifier() : super({});
  void getCurrentProductDetails(Map<String, dynamic> details) {
    state = details;
  }
}

final currentOrderProvider =
    StateNotifierProvider<_CurrentOrderNotifier, Map<String, dynamic>>(
  (ref) => _CurrentOrderNotifier(),
);

class _ConfirmOrderNotifier extends StateNotifier<Map<String, dynamic>> {
  _ConfirmOrderNotifier() : super({});

  Future<bool> placeOrder({
    required String productName,
    required String productPrice,
    required String customerName,
    required String email,
    required String mobileNumber,
    required String city,
    required String orderType,
    required String address,
    required int pincode,
    required int discountPercentage,
    required int finalAmount,
    required int amountPaid,
    required int amountPending,
    required String status,
    required String subCategoryId,
    required String userId,
    required String categoryId,
    required String productId,
    required String promotionalAdsId,
    required String discountVoucherId,
  }) async {
    const url = 'http://64.227.128.230/orders';
    final urlParse = Uri.parse(url);
    final data = {
      "productName": productName,
      "productPrice": productPrice,
      "customerName": customerName,
      "email": email,
      "mobileNumber": mobileNumber,
      "city": city,
      "orderType": orderType,
      "address": address,
      "pincode": pincode,
      "discountPercentage": discountPercentage,
      "finalAmount": finalAmount,
      "amountPaid": amountPaid,
      "amountPending": amountPending,
      "status": status,
      "userId": userId,
      "categoryId": categoryId,
      "subCategoryId": subCategoryId,
      "productId": productId,
      "promotionalAdsId": promotionalAdsId,
      "discountVoucherId": discountVoucherId,
    };
    final body = json.encode(data);

    try {
      final response = await http.post(urlParse,
          body: body, headers: {'content-Type': 'application/json'});
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> orderService(
      {required String customerName,
      required String mobileNumber,
      required String pincode,
      required String address,
      required String city,
      required String pstate,
      required String serviceDate,
      required String slot,
      required int paidAmount,
      required int pendingAmount,
      required int totalAmount,
      required String status,
      required String userId,
      required String categoryId,
      required String subCategoryId,
      required String serviceId}) async {
    const url = 'http://64.227.128.230/service-requests';
    final urlParse = Uri.parse(url);

    final data = {
      "customerName": customerName,
      "mobileNumber": mobileNumber,
      "pincode": pincode,
      "address": address,
      "city": city,
      "state": pstate,
      "serviceDate": serviceDate,
      "slot": slot,
      "paidAmount": paidAmount,
      "pendingAmount": pendingAmount,
      "totalAmount": totalAmount,
      "status": status,
      "userId": userId,
      "categoryId": categoryId,
      "subCategoryId": subCategoryId,
      "serviceId": serviceId
    };

    final body = json.encode(data);

    try {
      final response = await http.post(urlParse,
          body: body, headers: {'content-Type': 'application/json'});

      print("serviceRequest${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

final confirmOrderProvider =
    StateNotifierProvider<_ConfirmOrderNotifier, Map<String, dynamic>>(
  (ref) => _ConfirmOrderNotifier(),
);

Future<List> getUserOrderDetails(String userId) async {
  final url =
      'http://64.227.128.230/orders?filter={"offset": 0,"limit": 100,"skip": 0,"order": "createdAt desc","where": {"userId":"$userId"},"fields": {"orderId": true,"productName": true,"productPrice": true,"customerName": true,"email": true,"mobileNumber": true,"city": true,"orderType": true,"address": true,"pincode": true,"discountPercentage": true,"finalAmount": true,"amountPaid": true,"amountPending": true,"status": true,"createdAt": true,"userId": true,"categoryId": true,"subCategoryId": true,"productId": true,"promotionalAdsId": true,"discountVoucherId": true},"include": [{"relation": "product"}]}';
  final urlParse = Uri.parse(url);
  try {
    final response = await http.get(
      urlParse,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    return [];
  }
}
