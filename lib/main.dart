// lib/main.dart
import 'package:flutter/material.dart';
import 'views/Home/home_screen.dart';
import 'views/Search/search_screen.dart';
import 'views/Profile/profile_screen.dart';
import 'views/Layout/layout.dart';
import 'views/Home/start_page.dart'; // Importamos la pantalla de inicio

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookSwap',
      debugShowCheckedModeBanner: false,
      initialRoute: '/start', // Establecemos startPage como la ruta inicial
      routes: {
        '/start': (context) => const StartPage(), // Ruta para startPage
        '/home': (context) => const LayoutWrapper(index: 0), // El índice 0 es para Home
        '/search': (context) => const LayoutWrapper(index: 1),
        '/profile': (context) => const LayoutWrapper(index: 2),
      },
    );
  }
}

// A wrapper for the Layout widget to manage tab navigation
class LayoutWrapper extends StatelessWidget {
  final int index;
  const LayoutWrapper({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),    // Índice 0 - Home
      const SearchScreen(),  // Índice 1 - Buscar
      const ProfileScreen(), // Índice 2 - Perfil
    ];

    return Layout(
      body: screens[index],
      currentIndex: index,
      onTabSelected: (selectedIndex) {
        // Navegación en función del índice seleccionado
        String route;
        switch (selectedIndex) {
          case 0:
            route = '/home';
            break;
          case 1:
            route = '/search';
            break;
          case 2:
          default:
            route = '/profile';
            break;
        }
        if (selectedIndex != index) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }
}
