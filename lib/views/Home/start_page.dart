// lib/views/home/start_page.dart
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EFE7), // Fondo beige claro
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(), // Empuja el contenido hacia el centro

            // Título y descripción
            FadeTransition(
              opacity: _fadeInAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: const Column(
  children: [
    Text(
      'Bienvenido a',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w300,
        color: Color(0xFF8C2F39),
      ),
      textAlign: TextAlign.center,
    ),
    SizedBox(height: 10),
    Text(
      'BookSwap',
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Color(0xFF8C2F39),
      ),
      textAlign: TextAlign.center,
    ),
    SizedBox(height: 20),
    Text(
      'Intercambia tus libros favoritos con otros lectores. Explora, descubre y conecta con la comunidad de trueque de libros.',
      style: TextStyle(
        fontSize: 18,
        color: Color(0xFF8C2F39),
      ),
      textAlign: TextAlign.center,
    ),
  ],
),

              ),
            ),

            const SizedBox(height: 40), // Espacio entre el texto y la imagen

            // Imagen debajo del texto y encima del botón
            FadeTransition(
              opacity: _fadeInAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Image.asset(
                  'assets/libro.png', // Ruta de la imagen en assets
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const Spacer(), // Empuja el botón hacia la parte inferior de la pantalla

            // Botón "Continuar"
            FadeTransition(
              opacity: _fadeInAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C2F39), // Color del botón
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFF1EFE7), // Color del texto del botón
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
