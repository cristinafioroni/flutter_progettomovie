class Movie {
  final String title;
  final String director;
  final int duration;
  final String plot;
  final int year;

  Movie({
    required this.title,
    required this.director,
    required this.duration, 
    required this.plot, 
    required this.year});

    //* metodo per convertire un oggetto dart in un map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'director': director,
      'duration': duration,
      'plot': plot,
      'year': year,
    };

  }
  
    //* metodo per recuperare una map e trasformarla in un oggetto Movie
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      director: map['director'],
      duration: map['duration'],
      plot: map['plot'],
      year: map['year'],
    );
  } 
}
