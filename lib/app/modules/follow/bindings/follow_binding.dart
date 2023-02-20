import 'package:get/get.dart';

import '../controllers/follow_controller.dart';

class FollowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowController>(
      () => FollowController(),
    );
  }
}
