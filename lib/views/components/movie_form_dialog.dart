import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../models/movie.dart';
import '../../viewmodels/movie_view_model.dart';

class MovieFormDialog extends StatefulWidget {
  final Movie? movie;
  const MovieFormDialog({super.key, this.movie});

  @override
  State<MovieFormDialog> createState() => _MovieFormDialogState();
}

class _MovieFormDialogState extends State<MovieFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _directorController;
  late TextEditingController _durationController;
  late TextEditingController _plotController;
  late TextEditingController _yearController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.movie?.title ?? '');
    _directorController = TextEditingController(
      text: widget.movie?.director ?? '',
    );
    _durationController = TextEditingController(
      text: widget.movie?.duration.toString() ?? '',
    );
    _plotController = TextEditingController(text: widget.movie?.plot ?? '');
    _yearController = TextEditingController(
      text: widget.movie?.year.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _directorController.dispose();
    _durationController.dispose();
    _plotController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Qui puoi gestire l'invio del modulo, ad esempio creando o aggiornando un oggetto Movie
      final newMovie = Movie(
        id: widget.movie?.id,
        title: _titleController.text,
        director: _directorController.text,
        duration: int.parse(_durationController.text),
        plot: _plotController.text,
        year: int.parse(_yearController.text),
      );
      final vm = context.read<MovieViewModel>();
      if (widget.movie == null) {
        vm.addMovie(newMovie);
      } else {
        vm.updateMovie(newMovie);
      }
      Navigator.of(context).pop(newMovie);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
