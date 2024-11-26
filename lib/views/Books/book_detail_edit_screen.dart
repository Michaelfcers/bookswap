// lib/views/Books/book_details_screen.dart
import 'package:flutter/material.dart';
import '../../models/book_model.dart';
import '../../styles/colors.dart';
import 'book_edit_screen.dart';
import '../Profile/profile_screen.dart';
import '../Layout/layout.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  BookDetailsScreenState createState() => BookDetailsScreenState();
}

class BookDetailsScreenState extends State<BookDetailsScreen> {
  bool isExpanded = false;

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          title: Text(
            "Eliminar Libro",
            style: TextStyle(color: AppColors.textPrimary),
          ),
          content: Text(
            "¿Estás seguro de que deseas eliminar este libro?",
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancelar",
                style: TextStyle(color: AppColors.iconSelected),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconSelected,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const Layout(
                      body: ProfileScreen(),
                      currentIndex: 2,
                    ),
                  ),
                  (Route<dynamic> route) => false,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Libro eliminado"),
                    action: SnackBarAction(
                      label: "Deshacer",
                      onPressed: () {
                        // Lógica para simular la restauración del libro
                      },
                      textColor: AppColors.iconSelected,
                    ),
                  ),
                );
              },
              child: Text(
                "Eliminar",
                style: TextStyle(color: AppColors.textPrimary),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Book book = widget.book;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Detalles del Libro",
          style: TextStyle(color: AppColors.textPrimary),
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

            // Título
            Text(
              book.title,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Autor y género
            Text(
              "Autor: ${book.author}",
              style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              "Género: ${book.genre ?? 'Sin género especificado'}",
              style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Calificación
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Calificación:",
                  style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
                ),
                const SizedBox(width: 8),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      size: 24,
                      color: index < (book.rating ?? 4) ? Colors.amber : AppColors.shadow,
                    );
                  }),
                ),
                const SizedBox(width: 5),
                Text(
                  "${book.rating ?? 4.5}/5",
                  style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Sinopsis
            Text(
              "Sinopsis",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.iconSelected,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              book.description ?? "Sin descripción disponible.",
              textAlign: TextAlign.justify,
              maxLines: isExpanded ? null : 5,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
            ),
            if (book.description != null && book.description!.length > 100)
              TextButton(
                onPressed: () => setState(() => isExpanded = !isExpanded),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  backgroundColor: AppColors.iconSelected.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isExpanded ? "Ver menos" : "Ver más",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.iconSelected,
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // Botones de Editar y Eliminar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.iconSelected,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookEditScreen(book: book),
                      ),
                    );
                  },
                  child: Icon(Icons.edit, color: AppColors.textPrimary, size: 32),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => _showDeleteConfirmationDialog(context),
                  child: Icon(Icons.delete, color: AppColors.textPrimary, size: 32),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
