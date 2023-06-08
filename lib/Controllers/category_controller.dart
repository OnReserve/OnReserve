import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class CategoryController extends GetxController {
  var events = [];
  var args = Get.arguments;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // getEvents();
  }

  Future<List> getEvents() async {
    var response = await NetworkHandler.get(endpoint: 'events/');
    if (response[1] == 200) {
      try {
        events = response[0];
      } catch (e) {
        logger(CategoryController).e("Error: $e");
      }
    } else {}
    return events;
  }
}
