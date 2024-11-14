// lib/views/search_screen.dart
import 'package:flutter/material.dart';
import 'search_results_screen.dart';
import '../../styles/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchHistory = [];
  final List<String> _genres = [
    'Ficción', 'No ficción', 'Misterio', 'Ciencia ficción',
    'Romance', 'Fantasía', 'Historia', 'Poesía', 'Autoayuda'
  ];
  String? _selectedGenre;

  void _performSearch(String query, {bool isManual = true}) {
    setState(() {
      if (isManual && !_searchHistory.contains(query)) {
        _searchHistory.insert(0, query);
      }
      _searchController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsScreen(query: query),
        ),
      );
    });
  }

  void _selectGenre(String genre) {
    setState(() {
      _selectedGenre = genre;
      _performSearch(genre, isManual: false); 
    });
  }

  void _clearHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Buscar",
          style: TextStyle(color: AppColors.textLight),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de entrada de búsqueda
            TextField(
              controller: _searchController,
              onSubmitted: (value) => _performSearch(value),
              decoration: InputDecoration(
                hintText: 'Buscar libros, autores o géneros...',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.search, color: AppColors.iconSelected),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.cardBackground,
              ),
            ),
            const SizedBox(height: 16),

            // Filtros de Género
            const Text(
              "Explorar Géneros",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.iconSelected,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _genres.map((genre) {
                return ChoiceChip(
                  label: Text(genre),
                  selected: _selectedGenre == genre,
                  onSelected: (isSelected) => _selectGenre(genre),
                  selectedColor: AppColors.iconSelected,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: _selectedGenre == genre ? AppColors.textLight : AppColors.iconSelected,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Historial de búsqueda
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Historial de Búsquedas",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.iconSelected,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: AppColors.iconSelected),
                  onPressed: _clearHistory,
                  tooltip: 'Borrar historial',
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.history, color: AppColors.iconSelected),
                    title: Text(
                      _searchHistory[index],
                      style: const TextStyle(color: AppColors.iconSelected),
                    ),
                    onTap: () {
                      _performSearch(_searchHistory[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
