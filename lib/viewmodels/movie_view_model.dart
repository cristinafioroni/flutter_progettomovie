import 'package:flutter/material.dart';

import '../Models/movie.dart';
import '../service/movie_service.dart';

class MovieViewModel extends ChangeNotifier {
  final DBService _dbService = DBService();
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];
  List<Movie> get movies => _filteredMovies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //* metodo per recuperare tutti i movie dal database
  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();
    _movies = await _dbService.getAllMovies();
    _filteredMovies = _movies;
    _isLoading = false;
    notifyListeners();
  }

  //* metodo per aggiungere un movie al database
  Future<void> addMovie(Movie movie) async {
    await _dbService.insertMovie(movie);
    await fetchMovies(); // ricarica la lista aggiornata con i cambiamenti
  }

  //* metodo per cancellare un movie dal database
  Future<void> deleteMovie(int id) async {
    await _dbService.deleteMovie(id);
    await fetchMovies();
  }

  //* metodo per aggiornare un movie nel database
  Future<void> updateMovie(Movie movie) async {
    if (movie.id == null)
      return; // se l'id del movie è nullo, non possiamo aggiornarlo
    await _dbService.updateMovie(movie);
    await fetchMovies();
  }

  //* metodo per recuperare un film attraverso il suo id
  Movie? getMovieById(int id) {
    try {
      return _movies.firstWhere((movie) => movie.id == id);
    } catch (e) {
      return null;
    }
  }

  //* metodo per filtrare i movie in base a una query di ricerca
  void filterMovies(String query) {
    if (query.isEmpty) {
      _filteredMovies = List.from(_movies);
    } else {
      _filteredMovies = _movies.where(
            (movie) => 
            movie.title.toLowerCase().contains(query.toLowerCase()) ||
            movie.director.toLowerCase().contains(query.toLowerCase()) ||
            movie.plot.toLowerCase().contains(query.toLowerCase()) ||
            movie.year.toString().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }
}
