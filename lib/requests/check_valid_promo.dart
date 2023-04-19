/// This file contains the function to check if the promo code is valid or not and return the id of the promo code.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'routes_api.dart';

Future<List<Object>> checkPromo(
    BuildContext ctx, String promoCode, eventId) async {
  final url =
      Uri.parse('${RoutesAPI.checkPromo}${eventId}/${promoCode}/checkPromo');
  //print(promoCode);
  print(url);
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    List<Object> value = [];
    final jsonResponse = json.decode(response.body);
    //print('${jsonResponse['message']}');
    int responseStatus = response.statusCode;
    if (responseStatus == 200) {
      if (jsonResponse['message'] == "Promocode is valid.") {
        value = [true, jsonResponse['promocode']['_id']];
        //print(value[1]);
        return value;
      }
    }
    return [false, ""];
  } catch (error) {
    print(error);
    return [false, ""];
  }
}
