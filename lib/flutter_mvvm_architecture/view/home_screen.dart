import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../models/movie_api_model.dart';
import '../resources/componnets/custom_field.dart';
import '../resources/componnets/custom_sizebox.dart';
import '../resources/componnets/custom_text.dart';
import '../resources/utils/routes_name.dart';
import '../resources/utils/styles.dart';
import '../view_model/movie_apis_view_model.dart';
import '../view_model/user_view_model.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  MovieViewModel movieViewModel = MovieViewModel();
  String bg = ''; // Declare the bg variable
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    movieViewModel.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<UserViewModel>(context, listen: false);
    log(bg);
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: bg == ''
                  ? const DecorationImage(
                      image: AssetImage('assets/default.jpg'),
                    )
                  : DecorationImage(image: NetworkImage(bg), fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(0.2),
                      Colors.black,
                    ],
                  ),
                )),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: ChangeNotifierProvider<MovieViewModel>(
                      create: (context) => movieViewModel,
                      child: Consumer<MovieViewModel>(
                        builder: (BuildContext context, value, _) {
                          switch (value.moviesList.status) {
                            case Status.LOADING:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case Status.ERROR:
                              return Center(
                                child: CustomText(
                                  text: value.moviesList.message.toString(),
                                  color: Colors.white,
                                ),
                              );
                            case Status.COMPLETED:
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const CustomText(
                                          text: 'Search',
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            pref.removeUser().then((value) {
                                              context.pushReplacement(
                                                  RoutesName.splash);
                                            });
                                          },
                                          icon: const Icon(Icons.logout),
                                        ),
                                      ],
                                    ),
                                    CustomTextField(
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      controller: searchController,
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 10.0,
                                      ),
                                      enabledBorder: AppStyles.kmenuborder,
                                      border: AppStyles.kmenuborder,
                                      focusedBorder: AppStyles.kmenuborder,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      hintText:
                                          'Search title, categories, etc...',
                                    ),
                                    const Space(height: 16),
                                    const CustomText(
                                      text: 'Popular',
                                      color: Colors.white,
                                      weight: FontWeight.bold,
                                      size: 18,
                                    ),
                                    Expanded(
                                      child: MovieListWidget(
                                        value.moviesList.data!,
                                        bg: bg, // Pass the bg variable
                                        onPosterTap: (newBg) {
                                          // Update the bg variable when a movie is tapped
                                          setState(() {
                                            bg = newBg;
                                          });
                                        },
                                        controller: searchController,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            default:
                              return const CustomText(
                                text: 'Error',
                                color: Colors.white,
                              );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieListWidget extends StatefulWidget {
  final MovieApiModel movies;
  String bg;
  final TextEditingController controller;
  final Function(String) onPosterTap;
  MovieListWidget(
    this.movies, {
    required this.bg,
    super.key,
    required this.onPosterTap,
    required this.controller,
  });

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  List<Results> filteredMovies = [];

  @override
  void initState() {
    filteredMovies = widget.movies.results!; // Initialize with all movies
    widget.controller.addListener(_onSearchTextChanged);
    super.initState();
  }

  void _onSearchTextChanged() {
    String searchText = widget.controller.text.toLowerCase();
    setState(() {
      if (searchText.isEmpty) {
        filteredMovies = widget.movies.results!;
      } else {
        filteredMovies = widget.movies.results!
            .where((movie) =>
                movie.originalTitle!.toLowerCase().contains(searchText))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredMovies.length,
      itemBuilder: (context, index) {
        final result = filteredMovies[index];
        return GestureDetector(
          onTap: () {
            widget.onPosterTap(
                "https://image.tmdb.org/t/p/w500/${result.posterPath}");
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.29,
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://image.tmdb.org/t/p/w500/${result.posterPath}",
                    width: MediaQuery.of(context).size.width * 0.04,
                    height: MediaQuery.of(context).size.height * 0.25,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const Space(width: 10),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: result.originalTitle ?? '',
                      ),
                      CustomText(
                        text: 'Lang ${result.originalLanguage}',
                      ),
                      const Space(height: 10),
                      CustomText(
                        text: result.releaseDate ?? '',
                      ),
                      Text(
                        result.overview ?? '',
                        maxLines: 9,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onSearchTextChanged);
    super.dispose();
  }
}
