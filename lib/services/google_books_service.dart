import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:bookswap/models/book_model.dart';

class GoogleBooksService {
  Future<String> _loadApiKey() async {
    final config = await rootBundle.loadString('config.json');
    final data = json.decode(config);
    return data['apiKey'];
  }

  Future<List<Book>> fetchBooks(String query) async {
    final apiKey = await _loadApiKey(); // Carga la API key desde el archivo JSON
    final url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final books = data['items'] as List;
      return books.map((bookData) => Book.fromJson(bookData)).toList();
    } else {
      throw Exception('Error al cargar los libros');
    }
  }
}
