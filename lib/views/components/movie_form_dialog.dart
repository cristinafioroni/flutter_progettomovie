import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'custom_text_field.dart';
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
    final mediaQuery = MediaQuery.of(context);
    return AlertDialog(
      backgroundColor: AppColors.rose,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      title: Text(
        widget.movie == null ? 'Aggiungi Film' : 'Modifica Film',
        style: const TextStyle(
          fontFamily: 'Allura',
          fontSize: 40,
          color: AppColors.cream,
        ),
      ),

      content: SizedBox(
        width: mediaQuery.size.width * 0.8,
        child: SingleChildScrollView(
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

                      CustomTextField(
                        controller: _titleController,
                        label: "Titolo",
                        keyboardType: TextInputType.text,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Campo obbligatorio'
                            : null,
                      ),
                      CustomTextField(
                        controller: _directorController,
                        label: "Regista",
                        validator: (value) => value == null || value.isEmpty
                            ? 'Campo obbligatorio'
                            : null,
                      ),
                      CustomTextField(
                        controller: _durationController,
                        label: "Durata",
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value == null || int.tryParse(value) == null
                            ? 'Campo obbligatorio'
                            : null,
                      ),
                      CustomTextField(
                        controller: _plotController,
                        label: "Trama",
                        validator: (value) => value == null || value.isEmpty
                            ? 'Campo obbligatorio'
                            : null,
                      ),
                      CustomTextField(
                        controller: _yearController,
                        label: "Anno",
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
      ),
      actions: [
        // tasto annulla
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Annulla',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 16,
              color: AppColors.cream,
            ),
          ),
        ),

        // tasto salva
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.bordeaux,
            foregroundColor: AppColors.cream,
          ),
          onPressed: _submitForm,
          child: const Text(
            'Salva',
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
