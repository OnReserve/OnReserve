import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class HomeController extends GetxController {
  var isLoading = false;
  var categories = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<List> getCategories() async {
    isLoading = true;
    update();
    var response = await NetworkHandler.get(endpoint: 'categories/');
    if (response[1] == 200) {
      try {
        categories = response[0];
        isLoading = false;
        update();
      } catch (e) {
        isLoading = false;
        update();
      }
    } else {
      isLoading = false;
      update();
    }
    return categories;
  }
}
