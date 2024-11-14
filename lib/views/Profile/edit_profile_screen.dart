// lib/views/Profile/edit_profile_screen.dart
import 'package:flutter/material.dart';
import '../../styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController(text: "Usuario123");
  final TextEditingController nicknameController = TextEditingController(text: "user_nickname");
  final TextEditingController emailController = TextEditingController(text: "usuario123@example.com");

  // Constructor sin `const` y usando el super parámetro
  EditProfileScreen({super.key});

  void _saveChanges(BuildContext context) {
    // Mostrar confirmación de guardado
    showConfirmationDialog(context);

    // Mostrar SnackBar con opción para deshacer
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Cambios guardados"),
        action: SnackBarAction(
          label: "Deshacer",
          textColor: AppColors.iconSelected,
          onPressed: () {
            // Lógica para deshacer los cambios
            nameController.text = "Usuario123";
            nicknameController.text = "user_nickname";
            emailController.text = "usuario123@example.com";
          },
        ),
      ),
    );
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text(
            "¡Cambios guardados con éxito!",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textDark),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 50),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.iconSelected,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Aceptar",
                  style: TextStyle(color: AppColors.textLight),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Editar Perfil", style: TextStyle(color: AppColors.textLight)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textLight),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: AppColors.textLight),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.iconSelected,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: AppColors.textLight,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildFieldContainer("Nombre", nameController),
            const SizedBox(height: 20),
            _buildFieldContainer("Nickname", nicknameController),
            const SizedBox(height: 20),
            _buildFieldContainer("Correo", emailController),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconSelected,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => _saveChanges(context),
              child: const Text(
                "Guardar cambios",
                style: TextStyle(color: AppColors.textLight),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldContainer(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textLight,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          style: const TextStyle(color: AppColors.textDark),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
