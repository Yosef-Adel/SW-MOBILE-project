import 'dart:convert';

import 'package:envie_cross_platform/models/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/categories_provider.dart';
import 'routes_api.dart';

Future<List<Category>> getAllCategories(BuildContext context) async {
  final url = Uri.parse('${RoutesAPI.getAllCategories}');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    // print('Response: ${jsonResponse}');
    // print('${jsonResponse['categories']}');
    int responseStatus = response.statusCode;
    List<Category> categoriesList = [];
    if (responseStatus == 200) {
      for (var categoryDict in jsonResponse['categories']) {
        categoriesList.add(Category.fromJson(categoryDict));
      }
      Provider.of<CategoriesProvider>(context, listen: false).allCategories =
          categoriesList;
      return categoriesList;
    }
    return [];
  } catch (error) {
    print('Error: $error');
    return [];
  }
}
