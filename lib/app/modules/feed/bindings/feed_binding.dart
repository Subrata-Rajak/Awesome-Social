import 'package:get/get.dart';

import '../controllers/feed_controller.dart';

class FeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedController>(
      () => FeedController(),
    );
  }
}
