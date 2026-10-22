class Movie {
  final int? id;
  final String title;
  final String director;
  final int duration;
  final String plot;
  final int year;

  Movie({
    this.id,
    required this.title,
    required this.director,
    required this.duration, 
    required this.plot, 
    required this.year});

    //* metodo per convertire un oggetto dart in un map
  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'title': title,
      'director': director,
      'duration': duration,
      'plot': plot,
      'year': year,
    };

    if (id != null) {
      map['id'] = id as Object;
    }

    return map;
  }
  
    //* metodo per recuperare una map e trasformarla in un oggetto Movie
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      director: map['director'],
      duration: map['duration'],
      plot: map['plot'],
      year: map['year'],
    );
  } 
}
