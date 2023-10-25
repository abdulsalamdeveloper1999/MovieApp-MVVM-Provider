import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rest_apis_mvvm_movie_app/flutter_mvvm_architecture/view_model/user_view_model.dart';

import '../models/user_model.dart';
import '../repository/auth_repo/auth_repository.dart';
import '../resources/componnets/custom_snackbar.dart';
import '../resources/utils/routes_name.dart';

class AuthViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void updateLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final _myRepo = AuthRepository();

  Future<void> loginAPi(dynamic data, BuildContext context) async {
    final userSession = Provider.of<UserViewModel>(context, listen: false);
    updateLoading(true);
    _myRepo.loginApi(data).then((value) {
      userSession.saveUser(
        UserModel(
          token: value['token'].toString(),
        ),
      );
      updateLoading(false);
      log(value.toString());
      showSnackBar(context, 'Login Successfull');
      context.replace(RoutesName.menu);
    }).onError((error, stackTrace) {
      updateLoading(false);
      log(error.toString());
      showSnackBar(context, error.toString());
    });
  }

  Future<void> signUpApi(context, data) async {
    updateLoading(true);
    _myRepo.registerApi(data).then((value) {
      log(value.toString());
      context.replace(RoutesName.menu);
      showSnackBar(context, 'Registration Succesfull');
      updateLoading(false);
    }).onError((error, stackTrace) {
      showSnackBar(context, error.toString());
      updateLoading(false);
    });
  }
}
