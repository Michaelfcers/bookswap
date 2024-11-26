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
      backgroundColor: AppColors.scaffoldBackground, // Dinámico
      appBar: AppBar(
        backgroundColor: AppColors.primary, // Dinámico
        iconTheme: IconThemeData(color: AppColors.textPrimary), // Dinámico
        title: Text(
          widget.query, // Muestra el término o categoría en el encabezado
          style: TextStyle(color: AppColors.textPrimary), // Dinámico
        ),
      ),
      body: FutureBuilder<List<Book>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary), // Dinámico
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error al cargar resultados",
                style: TextStyle(color: AppColors.textPrimary), // Dinámico
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No se encontraron resultados",
                style: TextStyle(color: AppColors.textPrimary), // Dinámico
              ),
            );
          } else {
            final books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  leading: book.thumbnail.isNotEmpty
                      ? Image.network(
                          book.thumbnail,
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.book,
                          size: 50,
                          color: AppColors.iconSelected, // Dinámico
                        ),
                  title: Text(
                    book.title,
                    style: TextStyle(
                      color: AppColors.textPrimary, // Dinámico
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    book.author,
                    style: TextStyle(
                      color: AppColors.textSecondary, // Dinámico
                    ),
                  ),
                  onTap: () {
                    // Aquí puedes implementar una navegación hacia los detalles del libro
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
