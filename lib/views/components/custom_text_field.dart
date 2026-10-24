import 'package:flutter/material.dart';
import 'package:movie_prj/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  // impostare la funzione di validazione del campo di testo
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 16,
            color: AppColors.bordeaux,
          ),
        ),
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }
}