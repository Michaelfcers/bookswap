// lib/views/search_results_screen.dart
import 'package:flutter/material.dart';
import '../../models/book_model.dart';
import '../../services/google_books_service.dart';
import '../../styles/colors.dart'; // Importamos AppColors

class SearchResultsScreen extends StatefulWidget {
  final String query; // Ahora recibe el término de búsqueda

  const SearchResultsScreen({super.key, required this.query});

  @override
  SearchResultsScreenState createState() => SearchResultsScreenState();
}

// Removed the underscore to make this class public
class SearchResultsScreenState extends State<SearchResultsScreen> {
  final GoogleBooksService booksService = GoogleBooksService();
  late Future<List<Book>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = booksService.fetchBooks(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.textLight), // Agrega color al ícono de regresar
        title: Text(
          widget.query, // Muestra el término o categoría en el encabezado
          style: const TextStyle(color: AppColors.textLight),
        ),
      ),
      body: FutureBuilder<List<Book>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error al cargar resultados", style: TextStyle(color: AppColors.textLight)),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No se encontraron resultados", style: TextStyle(color: AppColors.textLight)),
            );
          } else {
            final books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  leading: book.thumbnail.isNotEmpty
                      ? Image.network(book.thumbnail, width: 50)
                      : const Icon(Icons.book, size: 50, color: AppColors.iconSelected), // Added `const`
                  title: Text(
                    book.title,
                    style: const TextStyle(color: AppColors.textLight),
                  ),
                  subtitle: Text(
                    book.author,
                    style: const TextStyle(color: AppColors.textLight), // Added `const`
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
