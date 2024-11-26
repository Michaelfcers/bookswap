// lib/views/Books/book_details_screen.dart
import 'package:flutter/material.dart';
import '../../models/book_model.dart';
import 'trade_proposal_screen.dart';
import '../../styles/colors.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final Book book = widget.book;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Detalles del Libro",
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
            const SizedBox(height: 16),

            // Título y detalles del autor y género
            Text(
              book.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Información del autor y género en una línea
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Autor: ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  TextSpan(
                    text: book.author,
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                  TextSpan(
                    text: ' | Género: ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  TextSpan(
                    text: book.genre ?? 'Sin género especificado',
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

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
            const SizedBox(height: 16),

            // Sinopsis con opción de ver más
            Text(
              "Sinopsis",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.iconSelected),
            ),
            const SizedBox(height: 12),
            Text(
              book.description?.isNotEmpty == true ? book.description! : "Sin descripción disponible.",
              textAlign: TextAlign.justify,
              maxLines: isExpanded ? null : 5,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
            ),
            if (book.description != null && book.description!.length > 100)
              Center(
                child: TextButton(
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
              ),
            const SizedBox(height: 24),

            // Botón Proponer Trueque
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconSelected,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Libros ficticios para propuesta de trueque
                List<Book> fakeAvailableBooks = [
                  Book(title: 'Libro A', author: 'Autor A', thumbnail: 'https://via.placeholder.com/150'),
                  Book(title: 'Libro B', author: 'Autor B', thumbnail: 'https://via.placeholder.com/150'),
                  Book(title: 'Libro C', author: 'Autor C', thumbnail: 'https://via.placeholder.com/150'),
                ];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TradeProposalScreen(availableBooks: fakeAvailableBooks),
                  ),
                );
              },
              child: Text(
                "Proponer Trueque",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
