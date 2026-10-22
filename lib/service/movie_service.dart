import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Models/movie.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class DBService {
  static final DBService _instance = DBService._internal();

  factory DBService() => _instance;
  DBService._internal();
  static Database? _database; //recuperare i dati del db

  Future<Database> get database async {
    if (_database != null) return _database!;
    // init serve per creare e aprire il database se non esiste ancora
    _database = await _initDB(); 
    return _database!;
  }

  Future<Database> _initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'movies.db');

    // apre o crea il db
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate, 
    );
  }

  Future<void> _onCreate(Database db, int version) async{
    await db.execute(
      '''
        CREATE TABLE movies(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT NOT NULL,
        director TEXT NOT NULL,
        duration INTEGER NOT NULL,
        plot TEXT NOT NULL,
        year INTEGER NOT NULL
      )
      '''
    );
  }

  //* insert movie
  // il dato è tipo int perchè rappresenta l'id del movie appena inserito nel db
  Future<int> insertMovie(Movie movie) async {
    final db = await database;
    return await db.insert(
      'movies', 
      movie.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //* lista oggetti movie
  Future<List<Movie>> getAllMovies() async {
    final db = await database;
    final result = await db.query('movies');
    return result.map((json) => Movie.fromMap(json)).toList();
  }

  //* elimina movie
  Future<int> deleteMovie(int id) async {
    final db = await database;
    return await db.delete(
      'movies',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  //* aggiorna movie nel database
  Future<int> updateMovie(Movie movie) async {
    final db = await database;
    return await db.update(
      'movies',
      movie.toMap(),
      where: 'id = ?',
      whereArgs: [movie.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}