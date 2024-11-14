// lib/models/book_model.dart

class Book {
  final String title;
  final String author;
  final String thumbnail;
  final String? genre;        // Nuevo campo opcional para género
  final double? rating;       // Nuevo campo opcional para calificación
  final String? description;  // Nuevo campo opcional para sinopsis

  Book({
    required this.title,
    required this.author,
    required this.thumbnail,
    this.genre,
    this.rating,
    this.description,
  });

  // Método para crear una instancia de Book desde JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];
    return Book(
      title: volumeInfo['title'] ?? 'Título desconocido',
      author: (volumeInfo['authors'] != null && volumeInfo['authors'].isNotEmpty)
          ? volumeInfo['authors'][0]
          : 'Autor desconocido',
      thumbnail: volumeInfo['imageLinks'] != null
          ? volumeInfo['imageLinks']['thumbnail']
          : 'https://via.placeholder.com/150', // Imagen de placeholder si no hay miniatura
      genre: (volumeInfo['categories'] != null && volumeInfo['categories'].isNotEmpty)
          ? volumeInfo['categories'][0]
          : 'Sin género especificado',
      rating: volumeInfo['averageRating'] != null
          ? (volumeInfo['averageRating'] as num).toDouble()
          : null, // Convierte calificación a double
      description: volumeInfo['description'], // Sinopsis
    );
  }
}
