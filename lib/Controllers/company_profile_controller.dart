import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class CompanyProfileController extends GetxController {
  var args = Get.arguments;
  var formKey = GlobalKey<FormState>();
  XFile? profilePic;
  XFile? coverPic;
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  List? categories;
  var companyProfile = {};

  @override
  void onInit() {
    super.onInit();
    getCompanyProfile();
    getCategories();
  }

  Future<void> getCategories() async {
    var response = await NetworkHandler.get(endpoint: 'categories/');
    if (response[1] == 200 || response[1] == 304) {
      try {
        List data = (response[0]);
        categories = data;
      } catch (e) {
        logger(CompanyProfileController).e(e);
      }
    }
  }

  Future<bool> removeEvent(int id) async {
    isLoading = true;
    update();
    var response = await NetworkHandler.delete(endpoint: 'event/$id');
    if (response[1] == 200) {
      isLoading = false;
      update();
      return true;
    }
    isLoading = false;
    update();
    return false;
  }

  Future<bool> removeAdmin(String email) async {
    isLoading = true;
    update();
    var body = {'email': email};
    var response = await NetworkHandler.delete(
        endpoint: 'company/${args['company']['id']}/admins', data: body);
    if (response[1] == 200) {
      // getCompanyProfile();
      isLoading = false;
      update();
      return true;
    }
    isLoading = false;
    update();
    return false;
  }

  Future<bool> addAdmin(String email) async {
    isLoading = true;
    update();
    var body = {'email': email};
    var response = await NetworkHandler.post(
        endpoint: 'company/${args['company']['id']}/admins', body: body);
    if (response[1] == 200) {
      // getCompanyProfile();
      isLoading = false;
      update();
      return true;
    }
    isLoading = false;
    update();
    return false;
  }

  getImage({required bool profile}) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    if (profile) {
      profilePic = null;
      profilePic = await picker.pickImage(source: ImageSource.gallery);
    } else {
      coverPic = null;
      coverPic = await picker.pickImage(source: ImageSource.gallery);
    }
    update();
  }

  Future<bool> editCompanyProfile() async {
    isLoading = true;
    update();
    late FormData formData;
    formData = FormData.fromMap(
      {
        'profilePic': profilePic == null
            ? null
            : await MultipartFile.fromFile(profilePic!.path,
                filename: 'Profile.jpg'),
        'coverPic': coverPic == null
            ? null
            : await MultipartFile.fromFile(coverPic!.path,
                filename: 'cover.jpg'),
        'name': name.text,
        'bio': bio.text
      },
    );

    var response = await NetworkHandler.put(
        body: formData, endpoint: 'company/${args['company']['id']}');
    if (response[1] == 200) {
      response[0].forEach((key, value) {
        if (args['company'].containsKey(key)) {
          args['company'][key] = value;
        }
      });
      isLoading = false;
      update();
      return true;
    }
    return false;
  }

  Future<Map> getCompanyProfile() async {
    var response =
        await NetworkHandler.get(endpoint: 'company/${args['company']['id']}');

    if (response[1] == 200) {
      companyProfile = response[0];
      return {
        "admin": response[0]['users'],
        "events": response[0]['events'],
        "company": response[0]
      };
    } else {
      return {"admin": [], "events": []};
    }
  }
}
