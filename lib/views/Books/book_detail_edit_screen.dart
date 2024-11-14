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
          title: const Text(
            "Eliminar Libro",
            style: TextStyle(color: AppColors.textDark),
          ),
          content: const Text(
            "¿Estás seguro de que deseas eliminar este libro?",
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: AppColors.iconSelected),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconSelected,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo de confirmación

// Redirige a la pantalla de perfil usando Layout directamente
Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute( // Eliminado `const` aquí
    builder: (context) => const Layout(body: ProfileScreen(), currentIndex: 2),
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
              child: const Text(
                "Eliminar",
                style: TextStyle(color: AppColors.textLight),
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
        title: const Text(
          "Detalles del Libro",
          style: TextStyle(color: AppColors.textLight),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textLight),
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
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(8),
              ),
              child: book.thumbnail.isNotEmpty
                  ? Image.network(book.thumbnail, fit: BoxFit.cover)
                  : const Center(child: Text('160 x 220', style: TextStyle(color: AppColors.textLight))),
            ),
            const SizedBox(height: 24),

            // Título
            Text(
              book.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textLight),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Autor y género
            Text(
              "Autor: ${book.author}",
              style: const TextStyle(fontSize: 18, color: AppColors.textLight),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              "Género: ${book.genre ?? 'Sin género especificado'}",
              style: const TextStyle(fontSize: 18, color: AppColors.textLight),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Calificación
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Calificación:", style: TextStyle(fontSize: 18, color: AppColors.textLight)),
                const SizedBox(width: 8),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      size: 24,
                      color: index < (book.rating ?? 4) ? Colors.amber : Colors.grey,
                    );
                  }),
                ),
                const SizedBox(width: 5),
                Text(
                  "${book.rating ?? 4.5}/5",
                  style: const TextStyle(fontSize: 18, color: AppColors.textLight),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Sinopsis
            const Text(
              "Sinopsis",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.iconSelected),
            ),
            const SizedBox(height: 12),
            Text(
              book.description ?? "Sin descripción disponible.",
              textAlign: TextAlign.justify,
              maxLines: isExpanded ? null : 5,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, color: AppColors.textLight),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.iconSelected,
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // Botones de Editar y Eliminar con fondo
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
                  child: const Icon(Icons.edit, color: AppColors.textLight, size: 32),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => _showDeleteConfirmationDialog(context),
                  child: const Icon(Icons.delete, color: AppColors.textLight, size: 32),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
