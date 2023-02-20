import 'package:get/get.dart';

import 'package:insta_clone/app/modules/post/controllers/customize_post_controller.dart';

import '../controllers/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomizePostController>(
      () => CustomizePostController(),
    );
    Get.lazyPut<PostController>(
      () => PostController(),
    );
  }
}
