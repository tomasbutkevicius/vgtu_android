import 'dart:convert';
import 'dart:math';

import 'package:flutter_app_9ld/models/response.dart';
import 'package:http/http.dart' as http;
//http://md5.jsontest.com/?text=example_text

class Api {
  Future<ResponseModel> fetch() async {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    final response = await http
        .get(Uri.parse('http://md5.jsontest.com/?text=' + randomNumber.toString()));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ResponseModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}