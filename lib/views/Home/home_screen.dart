import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/book_model.dart';
import '../../services/google_books_service.dart';
import '../Layout/layout.dart';
import '../Books/add_book_dialog.dart';
import '../Notifications/notifications_screen.dart';
import '../Messages/messages_screen.dart';
import '../Books/book_details_screen.dart';
import '../../styles/colors.dart';
import '../../auth_notifier.dart'; // Importamos AuthNotifier

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GoogleBooksService booksService = GoogleBooksService();
  List<Book> featuredBooks = [];
  List<Book> recommendedBooks = [];
  List<Book> popularBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final featured = await booksService.fetchBooks('flutter');
      final recommended = await booksService.fetchBooks('dart programming');
      final popular = await booksService.fetchBooks('technology');

      if (!mounted) return;

      setState(() {
        featuredBooks = featured;
        recommendedBooks = recommended;
        popularBooks = popular;
        isLoading = false;
      });
    } catch (error) {
      debugPrint('Error: $error');
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    // Si el usuario no está logueado, redirigimos al HomeScreenLoggedOut
    if (!authNotifier.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/homeLoggedOut'); // Ruta de HomeScreenLoggedOut
      });
      return Container(); // Contenedor vacío mientras se redirige
    }

    return Layout(
      body: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
          title: Text(
            "BookSwap",
            style: GoogleFonts.poppins(
              color: AppColors.tittle,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.message, color: AppColors.textPrimary),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MessagesScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: AppColors.textPrimary),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                );
              },
            ),
          ],
        ),
        body: Container(
          color: AppColors.scaffoldBackground,
          child: isLoading
              ? _buildSkeletonLoader()
              : RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: fetchBooks,
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      _buildSectionTitle("Libros Destacados"),
                      const SizedBox(height: 10),
                      _buildCarousel(featuredBooks),
                      const SizedBox(height: 20),
                      _buildSectionTitle("Recomendados para Ti"),
                      const SizedBox(height: 10),
                      _buildCarousel(recommendedBooks),
                      const SizedBox(height: 20),
                      _buildSectionTitle("Libros Populares"),
                      const SizedBox(height: 10),
                      _buildCarousel(popularBooks),
                    ],
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => const AddBookDialog(),
            );
          },
          child: Icon(Icons.add, color: AppColors.textPrimary),
        ),
      ),
      showBottomNav: false,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildCarousel(List<Book> books) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 280,
        enlargeCenterPage: true,
        viewportFraction: 0.6,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: books.map((book) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailsScreen(book: book),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.cardBackground,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Hero(
                    tag: 'book-${book.title}',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(book.thumbnail),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.author,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionTitle('Libros Destacados'),
        const SizedBox(height: 10),
        _buildSkeletonCarousel(),
        const SizedBox(height: 20),
        _buildSectionTitle('Recomendados para Ti'),
        const SizedBox(height: 10),
        _buildSkeletonCarousel(),
        const SizedBox(height: 20),
        _buildSectionTitle('Libros Populares'),
        const SizedBox(height: 10),
        _buildSkeletonCarousel(),
      ],
    );
  }

  Widget _buildSkeletonCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 280,
        enlargeCenterPage: true,
        viewportFraction: 0.6,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: List.generate(5, (index) {
        return Shimmer.fromColors(
          baseColor: AppColors.shadow,
          highlightColor: AppColors.cardBackground,
          period: const Duration(seconds: 1),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.cardBackground,
            ),
          ),
        );
      }),
    );
  }
}
