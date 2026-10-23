import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import 'components/movie_form_dialog.dart';

import '../viewmodels/movie_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // esegui codice dopo il primo frame renderizzato
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieViewModel>().fetchMovies();
    });

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        centerTitle: true,
        title: Image.asset('assets/images/movie_nights.png', height: 60),
      ),
      body: Consumer<MovieViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.movies.isEmpty) {
            return const Center(
              child: Text(
                'Nessun film disponibile',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            );
          }
          return const Text('sostituire con lista film');
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.bordeaux,
        foregroundColor: AppColors.ivory,
        onPressed: () {
          showDialog(context: context, builder: (_) => const MovieFormDialog());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
