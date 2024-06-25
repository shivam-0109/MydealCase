import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class _UserDocumentNotifier extends StateNotifier<List> {
  _UserDocumentNotifier() : super([]);

  Future<void> getUserUploadedDocument(String userId) async {
    log("Getting user document");
    final url =
        "http://64.227.128.230/user-documents? filter={offset: 0,limit: 100,skip: 0,order: string,where: {userId=$userId},fields: {userDocumentId: true,documentType: true,fileName: true,documentUrl: true,fileType: true,fileSize: true,status: true,userId: true},include: [{relation: user,scope: {offset: 0,limit: 100,skip: 0,order: string,where: {additionalProp1: {}},fields: {}}}]}";
    final urlParse = Uri.parse(url);

    try {
      final response = await http.get(urlParse);
      print(response.body);
      state = json.decode(response.body);
      print(state);
      log("done");
    } catch (e) {
      log("problem getting userdocument : ${e.toString()}");
    }
  }
}

final userDocumentProvider = StateNotifierProvider<_UserDocumentNotifier, List>(
  (ref) => _UserDocumentNotifier(),
);

class _UserDetails extends StateNotifier<Map<String, dynamic>> {
  _UserDetails() : super({});

  Future<void> getUserDetails(String userId) async {
    log("getting user details");
    final url = "http://64.227.128.230/users/$userId";
    try {
      final urlParse = Uri.parse(url);
      final response = await http.get(urlParse);
      print(response.body);
      if (response.statusCode == 200) {
        state = json.decode(response.body);
      }
      log("done");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> patchUserDocumentStatus(String userId, String status) async {
    log("Statrted updatting user details");
    final url = "http://64.227.128.230/users/$userId";

    final urlParse = Uri.parse(url);

    final data = {"status": status};
    final body = json.encode(data);
    try {
      final response = await http.patch(
        urlParse,
        body: body,
        headers: {'content-Type': 'application/json'},
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode >= 200 || response.statusCode <= 300) {
        log("updated");
      } else {
        log("something went wrong");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

final userDetailsProvider =
    StateNotifierProvider<_UserDetails, Map<String, dynamic>>(
  (ref) => _UserDetails(),
);

class _UserCurrnetLocation extends StateNotifier<Map<String, dynamic>> {
  _UserCurrnetLocation() : super({});

  void saveLocation(Map<String, dynamic> pos) {
    state = pos;
  }

  void setLocationEmpty() {
    state = {};
  }
}

final userCurrentLocationProvider =
    StateNotifierProvider<_UserCurrnetLocation, Map<String, dynamic>>(
  (ref) => _UserCurrnetLocation(),
);

class _UserAddressNotifer extends StateNotifier<Map<String, dynamic>> {
  _UserAddressNotifer() : super({});

  Future<String> saveUserAddress(
    String customerName,
    String phNumber,
    int pincode,
    String address,
    String city,
    String state,
    String addressType,
    double lat,
    double long,
    bool isDefault,
    String userID,
  ) async {
    log("uploading user address");
    final url = "http://64.227.128.230/user-addresses";

    final urlParse = Uri.parse(url);
    final data = {
      "customerName": customerName,
      "mobileNumber": phNumber,
      "pincode": pincode,
      "address": address,
      "city": city,
      "state": state,
      "addressType": addressType,
      "longitude": lat,
      "latitude": long,
      "isDefault": isDefault,
      "userId": userID
    };

    final body = json.encode(data);
    final response = await http.post(
      urlParse,
      body: body,
      headers: {'content-Type': 'application/json'},
    );
    print(response.body);
    return json.decode(response.body)["userAddressId"];
  }

  void setCurrentAddress(
    int pincode,
    String address,
    String city,
    String addState,
    String addressType,
  ) {
    state = {
      "address": address,
      "pincode": pincode,
      "city": city,
      "addState": addState,
      "addressType": addressType,
    };
  }

  void setAddEmpty() {
    state = {};
  }
}

final userAddressProvider =
    StateNotifierProvider<_UserAddressNotifer, Map<String, dynamic>>(
  (ref) => _UserAddressNotifer(),
);

class _AllUserAddress extends StateNotifier<List> {
  _AllUserAddress() : super([]);
  Future<void> getAlluserAddress(String userId) async {
    final url =
        'http://64.227.128.230/user-addresses?filter ={"offset": 0,"limit": 100,"skip": 0,"order": "string","where": {"userId":$userId},"fields": {"userAddressId": true,"customerName": true,"mobileNumber": true,"pincode": true,"address": true,"city": true,"state": true,"addressType": true,"longitude": true,"latitude": true,"isDefault": true,"createdAt": true,"userId": true},"include": [{"relation": "user","scope": {"offset": 0,"limit": 100,"skip": 0,"order": "string","where": {"additionalProp1": {}},"fields": {}}}]}';
    final urlParse = Uri.parse(url);
    try {
      final response = await http.get(
        urlParse,
      );

      print(response.body);
      state = json.decode(response.body);
    } catch (e) {
      print("something went wrong : ${e.toString()}");
    }
  }
}

final allUserProvider = StateNotifierProvider<_AllUserAddress, List>(
  (ref) => _AllUserAddress(),
);
