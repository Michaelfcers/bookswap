import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../styles/colors.dart';
import '../../styles/theme_notifier.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground, // Dinámico
      appBar: AppBar(
        backgroundColor: AppColors.primary, // Dinámico
        title: Text(
          "Configuración",
          style: TextStyle(
            color: AppColors.textPrimary, // Dinámico
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary), // Dinámico
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
            trailing: Text(
              "Español",
              style: TextStyle(
                color: AppColors.textPrimary, // Dinámico
                fontSize: 16,
              ),
            ),
            onTap: () {
              // Implementar cambio de idioma
            },
          ),
          Divider(color: AppColors.divider), // Dinámico
          SwitchListTile(
            activeColor: AppColors.iconSelected, // Dinámico
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Notificaciones",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textPrimary, // Dinámico
              ),
            ),
            value: true, // Cambia esto según el estado de las notificaciones
            onChanged: (bool value) {
              // Implementar activación/desactivación de notificaciones
            },
          ),
          Divider(color: AppColors.divider), // Dinámico
          // NUEVO SWITCH PARA TEMA OSCURO/CLARO
          SwitchListTile(
            activeColor: AppColors.iconSelected, // Dinámico
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Modo Oscuro",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textPrimary, // Dinámico
              ),
            ),
            value: themeNotifier.isDarkMode, // Determinamos el estado del tema actual
            onChanged: (bool value) {
              // Cambiamos el tema utilizando ThemeNotifier
              themeNotifier.updateTheme(value ? ThemeMode.dark : ThemeMode.light);
              AppColors.toggleTheme(value); // Actualizamos el tema en AppColors
            },
          ),
          Divider(color: AppColors.divider), // Dinámico
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
          Divider(color: AppColors.divider), // Dinámico
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
              backgroundColor: AppColors.iconSelected, // Dinámico
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () {
              // Implementar cierre de sesión
            },
            child: Text(
              "Cerrar sesión",
              style: TextStyle(
                color: AppColors.textPrimary, // Dinámico
                fontSize: 18,
              ),
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
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.iconSelected, // Dinámico
      ),
    );
  }

  // Helper para crear opciones de configuración con iconos y títulos más grandes
  Widget _buildSettingsOption(BuildContext context,
      {required IconData icon, required String title, Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: Icon(icon, color: AppColors.iconSelected, size: 28), // Dinámico
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary, // Dinámico
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
