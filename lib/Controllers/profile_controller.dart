import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:on_reserve/Controllers/theme_controller.dart';
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
  List? companies;
  List? categories;
  var formKey = GlobalKey<FormState>();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController compbio = TextEditingController();
  TextEditingController profbio = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  Future<void> logout() async {
    await SecuredStorage.clear();
    var control = Get.find<ThemeController>();
    if (control.dark) {
      control.toggle();
    }
    Get.offAllNamed(Routes.login);
  }

  @override
  void onInit() async {
    try {
      var userjson = await SecuredStorage.read(key: SharedKeys.user);
      if (userjson != null) user = User.fromJson(jsonDecode(userjson));
      getCategories();
    } catch (e) {
      logger(ProfileController).e(e);
    }
    super.onInit();
  }

  Future<bool> editProfile() async {
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
        'lname': lname.text,
        'fname': fname.text,
        'phoneNumber': phoneNumber.text,
        'bio': profbio.text
      },
    );

    var response = await NetworkHandler.post(
        body: formData, endpoint: 'profile/${user!.id}');
    if (response[1] == 200) {
      try {
        Map data = (response[0]);

        user = User.fromJson(data);

        await SecuredStorage.store(
            key: SharedKeys.user, value: jsonEncode(user!.toJson()));
        isLoading = false;
        update();
        return true;
      } catch (e) {
        logger(ProfileController).e(e);
        isLoading = false;
        update();
        return false;
      }
    }
    isLoading = false;
    update();
    return false;
  }

  Future<void> getImage({required bool profile}) async {
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

  Future<bool> deleteAccount() async {
    var response = await NetworkHandler.delete(endpoint: 'profile/${user!.id}');
    if (response[1] == 200) {
      try {
        await SecuredStorage.clear();
        Get.offAllNamed(Routes.login);
        return true;
      } catch (e) {
        logger(ProfileController).e(e);
        return false;
      }
    }
    return false;
  }

  Future<List> getCompanies() async {
    return await Future.delayed(
      const Duration(seconds: 1),
      () async {
        var response = await NetworkHandler.get(endpoint: 'companies/');
        if (response[1] == 200 || response[1] == 304) {
          try {
            List data = (response[0]);
            companies = data;
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

  Future<void> getCategories() async {
    var response = await NetworkHandler.get(endpoint: 'categories/');
    if (response[1] == 200 || response[1] == 304) {
      try {
        List data = (response[0]);
        categories = data;
      } catch (e) {
        logger(ProfileController).e(e);
      }
    }
  }

  Future<bool> addCompany() async {
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
        'bio': compbio.text
      },
    );

    var response =
        await NetworkHandler.post(body: formData, endpoint: 'company/add/');
    if (response[1] == 200) {
      getCompanies();
      update();
      isLoading = false;
      update();
      return true;
    }
    isLoading = false;
    update();
    return false;
  }
}
