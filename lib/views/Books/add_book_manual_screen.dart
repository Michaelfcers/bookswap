// lib/views/books/add_book_manual_screen.dart
import 'package:flutter/material.dart';
import '../../styles/colors.dart';

class AddBookManualScreen extends StatelessWidget {
  const AddBookManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: AppColors.textPrimary, // Color de la flecha de regreso
        ),
        title: Text(
          "Añadir Libro Manualmente",
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(Icons.image, size: 80, color: AppColors.iconSelected),
            ),
            Center(
              child: Text(
                "Sube una foto del libro",
                style: TextStyle(color: AppColors.iconSelected, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Título del libro',
              hint: 'Ingrese el título',
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              label: 'Género',
              hint: 'Ingrese el género',
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              label: 'Descripción / Sinopsis',
              hint: 'Ingrese una breve descripción',
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.iconSelected,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  // Implementar la lógica para guardar manualmente
                },
                child: Text(
                  "Guardar Libro",
                  style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint, required int maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.textSecondary),
            labelStyle: TextStyle(color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.iconSelected),
            ),
          ),
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
