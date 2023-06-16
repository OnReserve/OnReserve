import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:on_reserve/Models/user.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:on_reserve/helpers/storage/secure_store.dart';

class ProfileController extends GetxController {
  var isLoading = false;
  User? user;
  XFile? profilePic;
  XFile? coverPic;
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  Future<void> logout() async {
    await SecuredStorage.clear();
    Get.offAllNamed(Routes.login);
  }

  @override
  void onInit() async {
    try {
      var userjson = await SecuredStorage.read(key: SharedKeys.user);
      if (userjson != null) user = User.fromJson(jsonDecode(userjson));
    } catch (e) {
      logger(ProfileController).e(e);
    }
    super.onInit();
  }

  Future<bool> editProfile() async {
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
        'lname': lname.text,
        'fname': fname.text,
        'phoneNumber': phoneNumber.text,
        'bio': bio.text
      },
    );

    var response = await NetworkHandler.post(
        body: formData, endpoint: 'profile/${user!.id}');
    if (response[1] == 200) {
      try {
        Map data = (response[0]);

        user = User.fromJson(data);

        // Store The User
        await SecuredStorage.store(
            key: SharedKeys.user, value: jsonEncode(user!.toJson()));

        update();
        return true;
      } catch (e) {
        logger(ProfileController).e(e);
        return false;
      }
    }
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

  Future<List> getCompanies() async {
    return await Future.delayed(
      const Duration(seconds: 1),
      () async {
        var response = await NetworkHandler.get(endpoint: 'companies/');
        if (response[1] == 200 || response[1] == 304) {
          try {
            List data = (response[0]);
            return data;
          } catch (e) {
            logger(ProfileController).e(e);
            return [];
          }
        }
        return [];
      },
    );
  }

  Future<List> getUserEvents() async {
    return await Future.delayed(
      const Duration(seconds: 1),
      () async {
        var response = await NetworkHandler.get(endpoint: 'events/user/');
        if (response[1] == 200 || response[1] == 304) {
          try {
            List data = (response[0]);
            return data;
          } catch (e) {
            logger(ProfileController).e(e);
            return [];
          }
        }
        return [];
      },
    );
  }
}
