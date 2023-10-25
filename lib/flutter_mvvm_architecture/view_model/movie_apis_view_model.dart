import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../data/response/api_respose.dart';
import '../models/movie_api_model.dart';
import '../repository/movie_repo/movie_repository.dart';

class MovieViewModel with ChangeNotifier {
  final _myRepo = MovieRepository();

  ApiResponse<MovieApiModel> moviesList = ApiResponse.Loading();

  setMoviesList(ApiResponse<MovieApiModel> response) {
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMovies() async {
    setMoviesList(ApiResponse.Loading());

    _myRepo.getMovieApi().then((value) {
      log(value.results![0].id.toString());
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
