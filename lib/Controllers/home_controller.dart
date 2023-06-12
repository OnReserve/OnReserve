import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_reserve/Models/event_overview.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class HomeController extends GetxController {
  var categories = [];
  List<EventOverview> popularEvents = [];
  int currentPageIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  List<Event> events = [
    Event(
        title: "My Generation",
        subtitle: "Rophnans My Generation Concert Lorem Ipsum Odor",
        types: ["VIP", "VVIP"],
        imageURL: 'Rophnan.png'),
    Event(
        title: "Event NEW",
        subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        types: ["VIP", "Regular"],
        imageURL: 'Welcome_BG.png'),
    Event(
        title: "Check Event",
        subtitle: "Lorem Ipsum Generation ",
        types: ["Regular", "VVIP"],
        imageURL: 'Intro slider screen.png'),
  ];

  late Timer timer;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    startTimer();
    getCategories();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void stopTimer() {
    timer.cancel();
  }

  void changePage(int index) {
    currentPageIndex = index;
    update();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (currentPageIndex == events.length - 1) {
        currentPageIndex = 0;
      } else {
        currentPageIndex++;
      }
      if (pageController.hasClients)
        pageController.animateToPage(
          currentPageIndex,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
    });
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
                "http://res.cloudinary.com/dsgpxgwxs/image/upload/v1686106147/onReserve/Profile/s9r9od8ty6wm5czt3bme.png"),
        EventOverview(
            id: 2,
            title: "Rophnan Concert",
            date: "2021-10-10",
            imageURL:
                "http://res.cloudinary.com/dsgpxgwxs/image/upload/v1686106147/onReserve/Profile/s9r9od8ty6wm5czt3bme.png"),
        EventOverview(
            id: 3,
            title: "Rophnan Concert",
            date: "2021-10-10",
            imageURL:
                "http://res.cloudinary.com/dsgpxgwxs/image/upload/v1686106147/onReserve/Profile/s9r9od8ty6wm5czt3bme.png"),
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

class Event {
  final String title;
  final String subtitle;
  final List<String> types;
  final String imageURL;

  Event({
    required this.title,
    required this.subtitle,
    required this.types,
    required this.imageURL,
  });
}
