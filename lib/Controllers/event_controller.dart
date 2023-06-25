// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class EventController extends GetxController {
  var args = Get.arguments;

  final TextEditingController textEditingController = TextEditingController();

  List<Review> reviews = [];
  double rating = 3.0;
  double userRating = 3.0;
  bool isLoading = false;
  bool rated = false;
  String bookingToken = '';

  int economySeats = 1;
  int vipSeats = 0;

  num totalPrice = 0;
  num oldPrice = 0;

  void resetBottomSheet() {
    economySeats = 1;
    vipSeats = 0;
    totalPrice = 0;
    oldPrice = 0;
    update();
  }

  void setEconomySeats(double x) {
    try {
      economySeats = x.floor();
      oldPrice = totalPrice;
      totalPrice =
          (economySeats * args['economyPrice'] + vipSeats * args['vipPrice']) +
              0.0;
      print(totalPrice);
      update();
    } catch (e) {
      logger(EventController).e("Error: $e");
    }
  }

  Future<List<Review>> getReview() async {
    var response = await NetworkHandler.get(
      endpoint: 'event/${args['id']}/ratings',
    );

    if (response[1] == 200) {
      try {
        var res = List.generate(response[0]['reviews'].length, (index) {
          return Review(
              rating: response[0]['reviews'][index]['stars'],
              review: response[0]['reviews'][index]['comment'],
              userId: response[0]['reviews'][index]['userId']);
        });

        var controller2 = Get.find<ProfileController>();
        for (var i = 0; i < res.length; i++) {
          if (res[i].userId == controller2.user!.id) {
            rated = true;
            break;
          }
        }

        return res;
      } catch (e) {
        logger(EventController).e("Error: $e");
      }
    } else {
      return [];
    }
    return [];
  }

  Future<bool> addReview() async {
    isLoading = true;
    update();
    var body = {"comment": textEditingController.text, "stars": userRating};

    var response = await NetworkHandler.post(
      endpoint: 'event/${args['id']}/ratings',
      body: body,
    );

    if (response[1] == 200) {
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
      return false;
    }
    isLoading = false;
    update();
    return false;
  }

  void setVipSeats(double x) {
    try {
      vipSeats = x.floor();
      oldPrice = totalPrice;
      totalPrice = ((economySeats * args['economyPrice']) +
              (vipSeats * args['vipPrice'])) +
          0.0;
      print(totalPrice);
      update();
    } catch (e) {
      logger(EventController).e("Error: $e");
    }
  }

  Future<bool> reserveTicket() async {
    var response = await NetworkHandler.post(
      endpoint: 'booking/add/',
      body: {
        "eventId": args['id'],
        "economyCount": economySeats,
        "vipCount": vipSeats,
      },
    );
    if (response[1] == 200) {
      try {
        bookingToken = response[0]['bookingToken'];
        return true;
      } catch (e) {
        logger(EventController).e("Error: $e");
      }
    } else {
      return false;
    }
    return false;
  }
}

class Review {
  int rating = 3;
  String review = '';
  int userId = 0;

  Review({required this.rating, required this.review, required this.userId});
}
