import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Settings/settings_screen.dart';
import '../../styles/colors.dart';
import '../../styles/theme_notifier.dart';
import '../Login/login_screen.dart';

class ProfileLoggedOutScreen extends StatefulWidget {
  const ProfileLoggedOutScreen({super.key});

  @override
  State<ProfileLoggedOutScreen> createState() => _ProfileLoggedOutScreenState();
}

class _ProfileLoggedOutScreenState extends State<ProfileLoggedOutScreen> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return AnimatedBuilder(
      animation: themeNotifier, // Escucha cambios de ThemeNotifier
      builder: (context, _) {
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
                  // Navega a configuración y espera cambios de tema
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                  setState(() {}); // Fuerza una reconstrucción al regresar
                },
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 120,
                    color: AppColors.iconSelected, // Dinámico
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Accede a tu cuenta para gestionar tu perfil y tus libros",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary, // Dinámico
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.iconSelected, // Dinámico
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      "Iniciar Sesión",
                      style: TextStyle(
                        color: AppColors.textPrimary, // Dinámico
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
