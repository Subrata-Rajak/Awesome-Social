import 'package:get/get.dart';
import 'package:insta_clone/app/modules/personal_chat/controllers/personal_chat_controller.dart';

class PersonalChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalChatController>(
      () => PersonalChatController(),
    );
  }
}
