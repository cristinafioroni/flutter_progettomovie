import 'package:flutter/material.dart';
import 'package:movie_prj/core/theme/app_colors.dart';
import 'package:movie_prj/models/movie.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/movie_view_model.dart';
import 'movie_card.dart';

class MovieListWidget extends StatefulWidget {
  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MovieViewModel>();
    final movies = viewModel.movies;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];

              //* card
              return MovieCard(movie: movie);
            },
          ),
        ),
      ],
    );
  }
}


