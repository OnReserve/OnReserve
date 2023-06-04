import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_reserve/Models/event_overview.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class HomeController extends GetxController {
  var categories = [];
  List<EventOverview> popularEvents = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<List> getCategories() async {
    var response = await NetworkHandler.get(endpoint: 'categories/');
    if (response[1] == 200) {
      try {
        categories = response[0];
      } catch (e) {
        logger(HomeController).e("Error: $e");
      }
    } else {}
    return categories;
  }

  Future<List> getPopularEvents() async {
    await Future.delayed(const Duration(seconds: 2), () {
      popularEvents = [
        EventOverview(
            id: 1,
            title: "Rophnan Concert",
            date: "2021-10-10",
            imageURL:
                "http://res.cloudinary.com/dsgpxgwxs/image/upload/v1685919252/onReserve/Profile/q8ehvhsnwygyrnq5h97q.png"),
        EventOverview(
            id: 2,
            title: "Rophnan Concert",
            date: "2021-10-10",
            imageURL:
                "http://res.cloudinary.com/dsgpxgwxs/image/upload/v1685919252/onReserve/Profile/q8ehvhsnwygyrnq5h97q.png"),
        EventOverview(
            id: 3,
            title: "Rophnan Concert",
            date: "2021-10-10",
            imageURL:
                "http://res.cloudinary.com/dsgpxgwxs/image/upload/v1685919252/onReserve/Profile/q8ehvhsnwygyrnq5h97q.png"),
      ];
      return popularEvents;
    });
    return popularEvents;
    // var response = await NetworkHandler.get(endpoint: 'events/popular/');
    // if (response[1] == 200) {
    //   try {
    //     popularEvents =
    //         response[0].map((e) => EventOverview.fromJson(e)).toList();
    //   } catch (e) {
    //     logger(HomeController).e("Error: $e");
    //   }
    // } else {}
    // return categories;
  }
}
