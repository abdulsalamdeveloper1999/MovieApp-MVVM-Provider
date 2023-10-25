import 'dart:developer';

import 'package:go_router/go_router.dart';

import '../models/user_model.dart';
import '../resources/utils/routes_name.dart';
import '../view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(context) {
    getUserData().then((value) {
      if (value.token == null || value.token == '') {
        GoRouter.of(context).pushReplacement(RoutesName.login);
      } else {
        GoRouter.of(context).pushReplacement(RoutesName.menu);
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}
