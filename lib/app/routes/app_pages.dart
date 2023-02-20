import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:insta_clone/app/modules/personal_bookmarks/views/personal_bookmarks_view.dart';
import 'package:insta_clone/app/modules/personal_chat/bindings/personal_chat_binding.dart';
import 'package:insta_clone/app/modules/personal_chat/views/personal_chat_view.dart';

import '../common/get%20storage/local_storage_repo.dart';
import '../common/utils/strings.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/comment/bindings/comment_binding.dart';
import '../modules/comment/views/comment_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/feed/bindings/feed_binding.dart';
import '../modules/feed/views/feed_view.dart';
import '../modules/follow/bindings/follow_binding.dart';
import '../modules/follow/views/follow_view.dart';
import '../modules/follow/views/followers_view.dart';
import '../modules/follow/views/following_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/others_profile/bindings/others_profile_binding.dart';
import '../modules/others_profile/views/others_profile_view.dart';
import '../modules/personal_bookmarks/bindings/personal_bookmarks_bindings.dart';
import '../modules/personal_posts/bindings/personal_posts_binding.dart';
import '../modules/personal_posts/views/personal_posts_view.dart';
import '../modules/post/bindings/post_binding.dart';
import '../modules/post/views/customize_post_view.dart';
import '../modules/post/views/post_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  final LocalStorageRepo localStorageRepo = LocalStorageRepo();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.FEED,
      page: () => FeedView(),
      binding: FeedBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.POST,
      page: () => const PostView(),
      binding: PostBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOW,
      page: () => FollowView(),
      binding: FollowBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMIZE_POST,
      page: () => const CustomizePostView(),
      binding: PostBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOWING,
      page: () => FollowingView(),
      binding: FollowBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOWERS,
      page: () => FollowersView(),
      binding: FollowBinding(),
    ),
    GetPage(
      name: _Paths.OTHERS_PROFILE,
      page: () => const OthersProfileView(),
      binding: OthersProfileBinding(),
    ),
    GetPage(
      name: _Paths.COMMENT,
      page: () => const CommentView(),
      binding: CommentBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_CHAT,
      page: () => PersonalChatView(),
      binding: PersonalChatBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_POSTS,
      page: () => const PersonalPostsView(),
      binding: PersonalPostsBindings(),
    ),
    GetPage(
      name: _Paths.PERSONAL_BOOKMARKS,
      page: () => const PersonalBookmarksView(),
      binding: PersonalBookmarksBindings(),
    ),
  ];
}
