import 'package:flutter/material.dart';
import 'package:movie_prj/core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/movie_view_model.dart';


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
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                color: AppColors.bordeaux,
            
                child: ListTile(
                  title: Text(
                    movie.title,
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.ivory,
                    ),
                  ),
                  subtitle: Text(
                    "Anno: ${movie.year} - Regia: ${movie.director} - Durata: ${movie.duration} \n Trama: ${movie.plot}",
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 14,
                      color: AppColors.ivory,
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ]
    );
  }
}