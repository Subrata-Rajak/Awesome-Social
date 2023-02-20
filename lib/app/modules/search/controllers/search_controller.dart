import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  static SearchController get instance => Get.put(SearchController());

  var searchController = TextEditingController();
  var isShowUser = false.obs;
}
