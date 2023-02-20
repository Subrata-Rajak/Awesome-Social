import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/utils/strings.dart';

class TaggedPostsView extends GetView {
  const TaggedPostsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.face,
            size: 100,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppStrings.taggedPostsText,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white.withOpacity(0.3),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
