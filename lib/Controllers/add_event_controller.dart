import 'dart:async';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class AddEventController extends GetxController {
  var events = [];
  var args = Get.arguments;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // getEvents();
  }

  String formatDateAndTimeToTimestamp(String dateStr, String timeStr) {
    // Parse the date and time strings using the DateFormat class
    DateFormat dateFormat = DateFormat('M/d/yyyy h:mm a');
    DateTime dateTime = dateFormat.parse('$dateStr $timeStr');

    // Format the DateTime object as an ISO 8601 string with millisecond precision
    String iso8601String = dateTime.toIso8601String();

    // Return the ISO 8601 string with the 'Z' timezone indicator
    return '$iso8601String' + 'Z';
  }

  Future<bool> addEvent(Map<String, dynamic> x, {bool edit = false}) async {
    late FormData formData;

    var eventStartTime =
        formatDateAndTimeToTimestamp(x['eventStart'], x['eventStartTime']);
    var eventEndTime =
        formatDateAndTimeToTimestamp(x['eventStart'], x['eventEndTime']);
    var eventDeadline =
        formatDateAndTimeToTimestamp(x['Deadline Date'], x['eventDeadline']);

    formData = new FormData.fromMap({
      'companyId': x['companyId'],
      'title': x['title'],
      'desc': x['desc'],
      'eventStartTime': eventStartTime,
      'eventEndTime': eventEndTime,
      'eventDeadline': eventDeadline,
      'economySeats': x['economySeats'],
      'economyPrice': x['economyPrice'],
      'vipSeats': x['vipSeats'],
      'vipPrice': x['vipPrice'],
      'city': x['city'],
      'street': x['street'],
      'venue': x['venue'],
      'latitude': x['latitude'],
      'longitude': x['longitude'],
      'categories': x['categories'],
    });

    for (int i = 0; i < x['images'].length; i++) {
      String fieldName = "images";
      String filePath = x['images'][i];

      String fileName = basename(filePath);

      formData.files.add(MapEntry(fieldName,
          await MultipartFile.fromFile(filePath, filename: fileName)));
    }

    if (edit) {
      var response = await NetworkHandler.put(
          body: formData, endpoint: "event/${x['id']}");

      if (response[1] == 200) {
        try {
          update();
          return true;
        } catch (e) {
          logger(AddEventController).e(e);
          return false;
        }
      }
    } else {
      var response =
          await NetworkHandler.post(body: formData, endpoint: 'event/add/');

      if (response[1] == 200) {
        try {
          update();
          return true;
        } catch (e) {
          logger(AddEventController).e(e);
          return false;
        }
      }
    }
    return false;
  }
}
