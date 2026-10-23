import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../models/movie.dart';
import '../../viewmodels/movie_view_model.dart';
import '../../core/theme/app_colors.dart';

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
    return AlertDialog(
      backgroundColor: AppColors.bordeaux,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      title: Text(
        widget.movie == null ? 'Aggiungi Film' : 'Modifica Film',
        style: const TextStyle(
          fontFamily: 'Allura',
          fontSize: 40,
          color: AppColors.cream,
        ),
      ),

      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // parte interna del modulo con i campi di input
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: "Titolo",
                        labelStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          color: AppColors.bordeaux,
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Campo obbligatorio'
                          : null,
                    ),
                    TextFormField(
                      controller: _directorController,
                      decoration: const InputDecoration(
                        labelText: "Regista",
                        labelStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          color: AppColors.bordeaux,
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Campo obbligatorio'
                          : null,
                    ),
                    TextFormField(
                      controller: _durationController,
                      decoration: const InputDecoration(
                        labelText: "Durata",
                        labelStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          color: AppColors.bordeaux,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || int.tryParse(value) == null
                          ? 'Campo obbligatorio'
                          : null,
                    ),
                    TextFormField(
                      controller: _plotController,
                      decoration: const InputDecoration(
                        labelText: "Trama",
                        labelStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          color: AppColors.bordeaux,
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Campo obbligatorio'
                          : null,
                    ),
                    TextFormField(
                      controller: _yearController,
                      decoration: const InputDecoration(
                        labelText: "Anno",
                        labelStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          color: AppColors.bordeaux,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || int.tryParse(value) == null
                          ? 'Campo obbligatorio'
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annulla',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 16,
            color: AppColors.cream,
          ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.rose,
            foregroundColor: AppColors.cream,
          ),
          onPressed: _submitForm,
          child: const Text('Salva',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 16,
            color: AppColors.cream,
          ),
          ),
        ),
      ],
    );
  }
}
