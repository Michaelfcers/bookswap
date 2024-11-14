// lib/views/profile/settings_screen.dart
import 'package:flutter/material.dart';
import '../../styles/colors.dart'; // Importamos AppColors para colores globales

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Configuración",
          style: TextStyle(color: AppColors.textLight, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textLight),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle("Preferencias"),
          const SizedBox(height: 10),
          _buildSettingsOption(
            context,
            icon: Icons.language,
            title: "Idioma",
            trailing: const Text("Español", style: TextStyle(color: AppColors.textLight, fontSize: 16)),
            onTap: () {
              // Implementar cambio de idioma
            },
          ),
          const Divider(color: AppColors.divider),
          SwitchListTile(
            activeColor: AppColors.iconSelected,
            contentPadding: EdgeInsets.zero,
            title: const Text("Notificaciones", style: TextStyle(fontSize: 18, color: AppColors.textLight)),
            value: true, // Cambia esto según el estado de las notificaciones
            onChanged: (bool value) {
              // Implementar activación/desactivación de notificaciones
            },
          ),
          const Divider(color: AppColors.divider),

          const SizedBox(height: 20),
          _buildSectionTitle("Seguridad"),
          const SizedBox(height: 10),
          _buildSettingsOption(
            context,
            icon: Icons.lock,
            title: "Cambiar contraseña",
            onTap: () {
              // Implementar cambio de contraseña
            },
          ),
          const Divider(color: AppColors.divider),
          _buildSettingsOption(
            context,
            icon: Icons.description,
            title: "Políticas de uso",
            onTap: () {
              // Implementar visualización de políticas de uso
            },
          ),
          const SizedBox(height: 30),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.iconSelected,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () {
              // Implementar cierre de sesión
            },
            child: const Text(
              "Cerrar sesión",
              style: TextStyle(color: AppColors.textLight, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  // Helper para crear títulos de secciones
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.iconSelected),
    );
  }

  // Helper para crear opciones de configuración con iconos y títulos más grandes
  Widget _buildSettingsOption(BuildContext context,
      {required IconData icon, required String title, Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: Icon(icon, color: AppColors.iconSelected, size: 28),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textLight),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
