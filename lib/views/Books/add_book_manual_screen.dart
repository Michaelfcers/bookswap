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
        iconTheme: const IconThemeData(
          color: AppColors.textLight, // Color de la flecha de regreso
        ),
        title: const Text(
          "Añadir Libro Manualmente",
          style: TextStyle(color: AppColors.textLight),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.image, size: 80, color: AppColors.iconSelected),
            ),
            const Center(
              child: Text(
                "Sube una foto del libro",
                style: TextStyle(color: AppColors.iconSelected, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Título del libro',
                labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
                filled: true,
                fillColor: AppColors.cardBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.iconSelected),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.iconSelected),
                ),
              ),
              style: const TextStyle(color: AppColors.textLight),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Género',
                labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
                filled: true,
                fillColor: AppColors.cardBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.iconSelected),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.iconSelected),
                ),
              ),
              style: const TextStyle(color: AppColors.textLight),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Descripción / Sinopsis',
                labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
                filled: true,
                fillColor: AppColors.cardBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.iconSelected),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.iconSelected),
                ),
              ),
              style: const TextStyle(color: AppColors.textLight),
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
                child: const Text(
                  "Guardar Libro",
                  style: TextStyle(fontSize: 18, color: AppColors.textLight),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
