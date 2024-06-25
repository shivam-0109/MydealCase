import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_deal_case/View/LoginPage/CreatePage.dart';
import 'package:my_deal_case/View/LoginPage/LoginPage.dart';

Future<void> signUpUser() async {
  print('start');
  var url = 'http://64.227.128.230/users';
  var data = {
    'fullName': userNameController.text, // change
    'mobileNumber': userMobController.text,
    'city': cityController.text,
    "userProfilePic": "https://cdn-icons-png.flaticon.com/512/9131/9131529.png",
    "email": "user@gmail.com",
    // "gender": "male",
    // "state": "Uttar Pradesh",
    "isVerified": true,
    "userType": "user"
  };
  var bodyy = json.encode(data);
  log(bodyy);
  var urlParse = Uri.parse(url);
  try {
    final response = await http.post(
      urlParse,
      body: bodyy,
      headers: {'content-Type': 'application/json'},
    );
    final Map<String, dynamic> dataa = jsonDecode(response.body);
    log(dataa.toString());
    log('message');

    print('end');
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> loginUser() async {
  print('start');
  var url = 'http://64.227.128.230/users/login';
  var data = {
    'mobileNumber': userMobController.text,
  };
  var bodyy = json.encode(data);
  log(bodyy);

  var urlParse = Uri.parse(url);
  try {
    final response = await http.post(
      urlParse,
      body: bodyy,
      headers: {'content-Type': 'application/json'},
    );
    var dataa = jsonDecode(response.body);
    print(dataa);
    print('end');
  } catch (e) {
    print('Error: $e');
  }
}
