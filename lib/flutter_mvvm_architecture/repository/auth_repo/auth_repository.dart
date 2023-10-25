import 'dart:developer';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_service.dart';
import '../../resources/appurls.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.login, data);

      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.signup, data);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
