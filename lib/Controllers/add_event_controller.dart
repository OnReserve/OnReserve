import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:flutter/material.dart';
import 'package:on_reserve/Models/user.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';
import 'package:on_reserve/helpers/storage/secure_store.dart';

class AddEventController extends GetxController {
  var events = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // getEvents();
  }

  Future<bool> editProfile() async {
    late FormData formData;

    formData = new FormData.fromMap({
      'companyId': '1',
      'title': 'Yo Concert',
      'desc': 'Yearly Concert',
      'eventStartTime': '2023-06-01T00:00:00.000Z',
      'eventEndTime': '2023-06-07T00:00:00.000Z',
      'eventDeadline': '2023-06-02T00:59:38.034Z',
      'economySeats': '100',
      'economyPrice': '300',
      'vipSeats': '100',
      'vipPrice': '500',
      'city': 'Adama',
      'street': 'Mebrat',
      'venue': 'Eagle Hotel',
      'latitude': '100000',
      'longitude': '30000',
      'categories': '3',
      'images':
          await MultipartFile.fromFile('path/to/image', filename: 'AI.png')
    });

    var response =
        await NetworkHandler.post(body: formData, endpoint: 'event/add/');

    if (response[1] == 200) {
      try {
        Map data = (response[0]);

        update();
        return true;
      } catch (e) {
        logger(AddEventController).e(e);
        return false;
      }
    }
    return false;
  }
}
