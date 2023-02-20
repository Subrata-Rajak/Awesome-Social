import 'package:get/get.dart';

import '../controllers/personal_bookmarks_controller.dart';

class PersonalBookmarksBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalBookmarksController>(
      () => PersonalBookmarksController(),
    );
  }
}
