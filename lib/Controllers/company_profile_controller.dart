import 'package:get/get.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class CompanyProfileController extends GetxController {
  var args = Get.arguments;
  bool isLoading = false;
  var companyProfile = {};

  @override
  void onInit() {
    super.onInit();
    getCompanyProfile();
  }

  Future<bool> removeAdmin(int id) async {
    isLoading = true;
    update();
    var response = await NetworkHandler.delete(endpoint: 'user/$id');
    if (response[1] == 200) {
      companyProfile['users'].removeWhere((element) => element['id'] == id);
      isLoading = false;
      update();
      return true;
    }
    isLoading = false;
    update();
    return false;
  }

  Future<Map> getCompanyProfile() async {
    isLoading = true;
    update();
    if (companyProfile.isEmpty) {
      var response = await NetworkHandler.get(
          endpoint: 'company/${args['company']['id']}');
      if (response[1] == 200) {
        companyProfile = response[0];
        return {"admin": response[0]['users'], "events": response[0]['events']};
      } else {
        return {"admin": [], "events": []};
      }
    }
    isLoading = false;
    update();
    return {"admin": [], "events": []};
  }
}
