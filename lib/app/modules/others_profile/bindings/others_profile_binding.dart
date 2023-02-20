import 'package:get/get.dart';

import '../controllers/others_profile_controller.dart';

class OthersProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OthersProfileController>(
      () => OthersProfileController(),
    );
  }
}
