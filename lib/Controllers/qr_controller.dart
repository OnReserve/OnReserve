import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class QRController extends GetxController {
  bool scannedOnce = false;

  Future<bool> isValidCode(String code) async {
    // print(code);
    var data = {
      "bookingToken": code,
    };

    if (await InternetConnectionChecker().hasConnection) {
      var response = await NetworkHandler.put(body: data, endpoint: 'booking/');
      if (response[1] == 200) {
        showSimpleNotification(
            Text(
              'Succesful',
              style: TextStyle(color: Colors.white),
            ),
            background: Colors.green,
            duration: const Duration(seconds: 3));
        scannedOnce = true;
        return true;
      } else {
        if (!scannedOnce) {
          String err = '';
          print(response[1]);
          if (response[1] == 403) {
            err = 'You\'re not Authorized to check this ticket';
          }
          if (response[1] == 400) {
            err = 'Booking already checked out';
          }
          Future.delayed(
              Duration(seconds: 1),
              () => showSimpleNotification(
                  Text(
                    err,
                    style: TextStyle(color: Colors.white),
                  ),
                  background: Colors.red,
                  duration: const Duration(seconds: 3)));
          ;
        }
        return false;
      }
    }
    scannedOnce = true;
    return false;
  }
}
