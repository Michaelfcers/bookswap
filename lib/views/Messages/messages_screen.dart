// lib/views/messages/messages_screen.dart
import 'package:flutter/material.dart';
import '../Layout/layout.dart';
import 'chat_screen.dart';
import '../../styles/colors.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            "Mensajes",
            style: TextStyle(
              color: AppColors.textLight,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textLight),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          children: const [
            // Chat 1
            _ChatItem(
              chatTitle: "Usuario123",
              lastMessage: "Hola, ¿aceptas el trueque?",
              time: "10:30 AM",
            ),
            Divider(color: AppColors.divider, thickness: 1),

            // Chat 2
            _ChatItem(
              chatTitle: "BookLover",
              lastMessage: "Perfecto, hago el envío mañana.",
              time: "9:15 AM",
            ),
          ],
        ),
      ),
      currentIndex: 0,
      onTabSelected: (index) {
        // Aquí se puede definir el cambio de pantalla si se necesita
      },
    );
  }
}

class _ChatItem extends StatelessWidget {
  final String chatTitle;
  final String lastMessage;
  final String time;

  const _ChatItem({
    required this.chatTitle,
    required this.lastMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatScreen(chatTitle: chatTitle),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.shadow,
              radius: 28,
              child: Icon(Icons.person, color: AppColors.textLight, size: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    lastMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
