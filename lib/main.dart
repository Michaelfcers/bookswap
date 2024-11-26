import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importamos Provider para manejar el estado global
import 'styles/colors.dart'; // Importamos los colores y lógica dinámica
import 'styles/theme_notifier.dart'; // Importamos ThemeNotifier
import 'views/Home/home_screen.dart';
import 'views/Search/search_screen.dart';
import 'views/Profile/profile_screen.dart';
import 'views/Profile/profile_logged_out_screen.dart'; // Nueva pantalla
import 'views/Layout/layout.dart';
import 'views/Home/start_page.dart'; // Importamos la pantalla de inicio

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(), // Proveemos ThemeNotifier
      child: const MyApp(),
    ),
  );
}

// Simulación de estado global para inicio de sesión
bool isUserLoggedIn = false; // Cambiar según el estado del usuario

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context); // Accedemos al estado del tema actual

    return MaterialApp(
      title: 'BookSwap',
      debugShowCheckedModeBanner: false,
      theme: AppColors.getThemeData(false), // Tema claro personalizado desde AppColors
      darkTheme: AppColors.getThemeData(true), // Tema oscuro personalizado desde AppColors
      themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light, // Selección dinámica de tema
      initialRoute: '/start', // Ruta inicial
      routes: {
        '/start': (context) => const StartPage(), // Pantalla inicial
        '/home': (context) => const LayoutWrapper(index: 0), // Pantalla Home
        '/search': (context) => const LayoutWrapper(index: 1), // Pantalla Buscar
        '/profile': (context) => const LayoutWrapper(index: 2), // Pantalla Perfil
      },
    );
  }
}

// Wrapper para administrar la navegación entre tabs en el layout principal
class LayoutWrapper extends StatelessWidget {
  final int index;
  const LayoutWrapper({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),    // Índice 0 - Home
      const SearchScreen(),  // Índice 1 - Buscar
      isUserLoggedIn
          ? const ProfileScreen() // Índice 2 - Perfil (logueado)
          : const ProfileLoggedOutScreen(), // Índice 2 - Perfil (no logueado)
    ];

    return Layout(
      body: screens[index], // Pantalla actual según el índice
      currentIndex: index,
      onTabSelected: (selectedIndex) {
        // Navegación según la tab seleccionada
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
          Navigator.pushReplacementNamed(context, route); // Navegación con reemplazo
        }
      },
    );
  }
}
