import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/book_model.dart';
import '../../../services/google_books_service.dart';
import '../Settings/settings_screen.dart';
import '../Books/add_book_dialog.dart';
import '../Books/book_detail_edit_screen.dart';
import '../../styles/colors.dart'; // Importamos AppColors
import 'edit_profile_screen.dart'; // Importamos la nueva pantalla de edición de perfil
import '../../styles/theme_notifier.dart'; // Importamos el ThemeNotifier
import '../../auth_notifier.dart'; // Importamos el AuthNotifier

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final GoogleBooksService booksService = GoogleBooksService();
  List<Book> uploadedBooks = [];
  bool isLoading = true;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchUploadedBooks();
  }

  Future<void> fetchUploadedBooks() async {
    try {
      final books = await booksService.fetchBooks("technology");
      setState(() {
        uploadedBooks = books.take(4).toList();
        isLoading = false;
      });
    } catch (error) {
      debugPrint('Error al cargar los libros: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final authNotifier = Provider.of<AuthNotifier>(context); // Accedemos al AuthNotifier


    // Si el usuario no está logueado, redirigimos al ProfileLoggedOutScreen
    if (!authNotifier.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/profile'); // Redirige al perfil sin sesión
      });
      return Container(); // Devuelve un contenedor vacío mientras se realiza la redirección
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground, // Dinámico
      appBar: AppBar(
        backgroundColor: AppColors.primary, // Dinámico
        title: Text(
          "Perfil",
          style: TextStyle(color: AppColors.textPrimary), // Dinámico
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: AppColors.textPrimary), // Dinámico
            onPressed: () async {
              // Abrimos la pantalla de configuración y esperamos su resultado
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
              // Actualizamos el estado tras regresar
              setState(() {
                AppColors.toggleTheme(themeNotifier.isDarkMode);
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.shadow, // Dinámico
                  child: Icon(Icons.person,
                      size: 40, color: AppColors.textPrimary), // Dinámico
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Usuario123',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary, // Dinámico
                        ),
                      ),
                      Text(
                        'Nivel 5 - Lector Ávido',
                        style: TextStyle(color: AppColors.textPrimary), // Dinámico
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: 0.75,
                        color: AppColors.iconSelected, // Dinámico
                        backgroundColor: AppColors.shadow, // Dinámico
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '750/1000 XP',
                        style: TextStyle(color: AppColors.textPrimary), // Dinámico
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.iconSelected), // Dinámico
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Editar perfil",
                          style:
                              TextStyle(color: AppColors.iconSelected), // Dinámico
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabIcon(Icons.book, 0),
                _buildTabIcon(Icons.emoji_events, 1),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _selectedTabIndex == 0
                    ? _buildBooksGrid()
                    : _buildAchievementsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        itemCount: uploadedBooks.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const AddBookDialog(),
                );
              },
              child: Card(
                color: AppColors.cardBackground, // Dinámico
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add,
                          color: AppColors.iconSelected, size: 36), // Dinámico
                      const SizedBox(height: 8),
                      Text(
                        'Agregar libro',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.iconSelected, // Dinámico
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            final book = uploadedBooks[index - 1];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailsScreen(book: book),
                  ),
                );
              },
              child: Card(
                color: AppColors.cardBackground, // Dinámico
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(book.thumbnail),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary, // Dinámico
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        book.author,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary, // Dinámico
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAchievementsList() {
    final achievements = [
      {
        "title": "Bibliófilo Novato",
        "description": "Subir 5 libros para trueque."
      },
      {
        "title": "Lector Ávido",
        "description": "Realizar 10 trueques exitosos."
      },
      {
        "title": "Explorador de Géneros",
        "description": "Trueques en 5 géneros diferentes."
      },
    ];

    return ListView.builder(
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return Card(
          color: AppColors.cardBackground, // Dinámico
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          child: ListTile(
            leading: Icon(Icons.emoji_events,
                color: AppColors.iconSelected), // Dinámico
            title: Text(
              achievement["title"]!,
              style: TextStyle(color: AppColors.textSecondary), // Dinámico
            ),
            subtitle: Text(
              achievement["description"]!,
              style: TextStyle(color: AppColors.textSecondary), // Dinámico
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabIcon(IconData icon, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _selectedTabIndex == index
                    ? AppColors.iconSelected
                    : Colors.transparent, // Dinámico
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              color: _selectedTabIndex == index
                  ? AppColors.iconSelected
                  : AppColors.textPrimary, // Dinámico
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
