import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class RequestMoneyController extends GetxController {
  var args = Get.arguments;
  var details = {};
  bool can = true;
  bool isLoading = false;

  var formKey = GlobalKey<FormState>();
  TextEditingController bank = TextEditingController();
  // TextEditingController lname = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    can = await getRequest();
    update();
  }

  Future<bool> getRequest() async {
    var response = await NetworkHandler.get(
        endpoint: 'event/${args['event']['id']}/payment');

    if (response[1] == 200) {
      details = response[0];
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendRequest() async {
    isLoading = true;
    update();
    var body = {
      "bank": bank.text,
    };
    var response = await NetworkHandler.post(
        endpoint: 'event/${args['event']['id']}/payment', body: body);

    if (response[1] == 200) {
      details = response[0];
      isLoading = false;
      update();
      return true;
    } else {
      return false;
    }
  }
}
