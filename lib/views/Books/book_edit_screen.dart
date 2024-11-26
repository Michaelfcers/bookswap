// lib/views/Books/book_edit_screen.dart
import 'package:flutter/material.dart';
import '../../models/book_model.dart';
import '../../styles/colors.dart';

class BookEditScreen extends StatelessWidget {
  final Book book;

  const BookEditScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(text: book.title);
    final TextEditingController authorController = TextEditingController(text: book.author);
    final TextEditingController genreController = TextEditingController(text: book.genre ?? '');
    final TextEditingController descriptionController = TextEditingController(text: book.description ?? '');

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Editar Libro",
          style: TextStyle(color: AppColors.textPrimary, fontSize: 22),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen del libro
            Container(
              width: 160,
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.shadow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: book.thumbnail.isNotEmpty
                  ? Image.network(book.thumbnail, fit: BoxFit.cover)
                  : Center(
                      child: Text(
                        '160 x 220',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                    ),
            ),
            const SizedBox(height: 24),

            // Campos de edición
            _buildTextField(titleController, 'Título'),
            const SizedBox(height: 10),
            _buildTextField(authorController, 'Autor'),
            const SizedBox(height: 10),
            _buildTextField(genreController, 'Género'),
            const SizedBox(height: 10),
            _buildTextField(descriptionController, 'Descripción / Sinopsis', maxLines: 3),
            const SizedBox(height: 24),

            // Botón de Guardar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconSelected,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Libro editado con éxito',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    backgroundColor: AppColors.cardBackground,
                  ),
                );
              },
              child: Text(
                "Guardar cambios",
                style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.iconSelected),
        filled: true,
        fillColor: AppColors.cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.iconSelected),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.iconSelected),
        ),
      ),
      style: TextStyle(color: AppColors.textPrimary),
    );
  }
}
