// lib/views/notifications/notifications_screen.dart
import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import '../Layout/layout.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            "Notificaciones",
            style: TextStyle(color: AppColors.textPrimary),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            NotificationCard(
              icon: Icons.card_giftcard,
              title: "Nueva solicitud de trueque",
              subtitle: "Un usuario ha solicitado un trueque con tu libro.",
            ),
            NotificationCard(
              icon: Icons.check_circle,
              title: "Tu trueque ha sido aceptado",
              subtitle: "Tu solicitud de trueque ha sido aceptada por el usuario.",
            ),
            NotificationCard(
              icon: Icons.chat,
              title: "Un usuario ha comentado tu libro",
              subtitle: "Revisa los nuevos comentarios en tu publicación.",
            ),
          ],
        ),
      ),
      currentIndex: 0,
    );
  }
}

// Widget de tarjeta de notificación reutilizable
class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBackground,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: AppColors.iconSelected, size: 30),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
