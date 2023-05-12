/// This file contains the function to check if the promo code is valid or not and return the id of the promo code.

import 'dart:convert';

import '../models/report.dart';
import '../providers/dashboard_provider.dart';
import '../screens/creator_sales_report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/creator_event_provider.dart';
import '../providers/user_provider.dart';
import 'routes_api.dart';

Future<Map<String, dynamic>> fetchData(BuildContext context) async {
  String? eventID =
      Provider.of<CreatorEventProvider>(context, listen: false).selectedEventId;
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final url = Uri.parse(
      '${RoutesAPI.creatorGetEvents}/$eventID/getTicketsSoldForEvent');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  print(url);
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    int responseStatus = response.statusCode;
    if (responseStatus == 200) {
      return json.decode(response.body);
    }
    return {};
  } catch (error) {
    print('Error: $error');
    throw error;
  }
}

Future<Map<String, dynamic>> fetchUrl(BuildContext context) async {
  String? eventID =
      Provider.of<CreatorEventProvider>(context, listen: false).selectedEventId;
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final url = Uri.parse('${RoutesAPI.creatorGetEvents}/$eventID/getEventUrl');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    int responseStatus = response.statusCode;
    if (responseStatus == 200) {
      return json.decode(response.body);
    }
    return {};
  } catch (error) {
    print('Error: $error');
    throw error;
  }
}

Future<Map<String, dynamic>> fetchSalesReport(BuildContext context) async {
  String? eventID =
      Provider.of<CreatorEventProvider>(context, listen: false).selectedEventId;
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final url =
      Uri.parse('${RoutesAPI.creatorGetEvents}/$eventID/getSalesSummaryReport');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    int responseStatus = response.statusCode;
    if (responseStatus == 200) {
      return json.decode(response.body);
    }
    return {};
  } catch (error) {
    print('Error while fetching sales report: $error');
    throw error;
  }
}

Future<List<SalesReport>> fetchTicketsSales(BuildContext context) async {
  String? eventID =
      Provider.of<CreatorEventProvider>(context, listen: false).selectedEventId;
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final url = Uri.parse(
      '${RoutesAPI.creatorGetEvents}/$eventID/getSalesByTicketTypeDashboard');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    int responseStatus = response.statusCode;
    print(jsonResponse);

    if (responseStatus == 200) {
      List<SalesReport> reportsList = [];
      final Dict = jsonResponse['Report'];

      for (var reportDict in Dict) {
        reportsList.add(SalesReport.fromJson(reportDict));
      }
      return reportsList;
    }
    return [];
  } catch (error) {
    print('Error while fetching tickets sales: $error');
    return [];
  }
}

Future<List<AttendeeReport>> getAttendeeReport(
    BuildContext context, int currentPage) async {
  String? eventID =
      Provider.of<CreatorEventProvider>(context, listen: false).selectedEventId;
  String? token = Provider.of<UserProvider>(context, listen: false).token;
  final url = Uri.parse(
      '${RoutesAPI.creatorGetEvents}/$eventID/getAttendeeReport?page=$currentPage');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  print(url);
  try {
    final response = await http.get(
      url,
      headers: headers,
    );
    final jsonResponse = json.decode(response.body);
    int responseStatus = response.statusCode;
    //print(jsonResponse);

    Provider.of<DashboardProvider>(context, listen: false).maxPages =
        jsonResponse['pagination']['totalPages'];

    if (responseStatus == 200) {
      List<AttendeeReport> reportsList = [];
      final Dict = jsonResponse['Report'];

      for (var reportDict in Dict) {
        reportsList.add(AttendeeReport.fromJson(reportDict));
      }
      return reportsList;
    }
    return [];
  } catch (error) {
    print('Error while fetching attendee report: $error');
    return [];
  }
}
