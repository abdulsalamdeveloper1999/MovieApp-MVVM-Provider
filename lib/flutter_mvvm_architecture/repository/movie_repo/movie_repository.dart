import 'dart:developer';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_service.dart';
import '../../models/movie_api_model.dart';
import '../../resources/appurls.dart';

class MovieRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<MovieApiModel> getMovieApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.movieApiUrl);

      if (response is Map<String, dynamic>) {
        log('Received a response with results field.');
      } else {
        log('Received an unexpected response type.');
        // Handle the unexpected response here.
      }
      return MovieApiModel.fromJson(response);
    } catch (e) {
      log('Error is $e');
      rethrow;
    }
  }
}
// import 'dart:developer';

// import 'package:toturials/flutter_mvvm_architecture/data/network/base_api_services.dart';
// import 'package:toturials/flutter_mvvm_architecture/data/network/network_api_service.dart';
// import 'package:toturials/flutter_mvvm_architecture/models/movie_api_model.dart';
// import 'package:toturials/flutter_mvvm_architecture/resources/appurls.dart';

// class MovieRepository {
//   final BaseApiServices _apiServices = NetworkApiService();

//   Future<List<MovieApiModel>> getMovieApi() async {
//     try {
//       dynamic response =
//           await _apiServices.getGetApiResponse(AppUrl.movieApiUrl);

//       if (response is List<dynamic>) {
//         log('Received a List response.');
//         // Perform the necessary processing to convert the List to a List<MovieApiModel>.
//         List<MovieApiModel> movies =
//             response.map((item) => MovieApiModel.fromJson(item)).toList();
//         // log(movies[0].results.toString());
//         return movies;
//       } else {
//         log('Received an unexpected response type.');
//         // You can return an empty list or throw an exception based on your application logic.
//         return [];
//       }
//     } catch (e) {
//       log('Error is $e');
//       rethrow;
//     }
//   }
// }
