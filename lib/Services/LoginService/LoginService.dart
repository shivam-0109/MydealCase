import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_deal_case/View/LoginPage/LoginPage.dart';

Future<void> loginUser() async {
  print('start');
  var url = 'http://64.227.128.230/users/login';
  var data = {
    'mobileNumber': numController.text,
  };
  var bodyy = json.encode(data);
  print(bodyy);
  print(Number);
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
