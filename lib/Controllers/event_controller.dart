import 'package:get/get.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class EventController extends GetxController {
  var args = Get.arguments;

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
        print(response[0]);
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
