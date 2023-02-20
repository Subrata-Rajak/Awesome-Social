import 'package:get/get.dart';

import '../firebase/post_model.dart';

class PersonalBookmarksViewArguments {
  final RxList<PostModel> listOfPostModels;

  PersonalBookmarksViewArguments({
    required this.listOfPostModels,
  });
}
