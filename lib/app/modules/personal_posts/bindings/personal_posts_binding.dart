import 'package:get/get.dart';
import 'package:insta_clone/app/modules/personal_posts/controllers/personal_posts_controller.dart';

class PersonalPostsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalPostsController>(
      () => PersonalPostsController(),
    );
  }
}
