// lib/views/messages/chat_screen.dart
import 'package:flutter/material.dart';
import '../../styles/colors.dart'; // Importamos AppColors

class ChatScreen extends StatelessWidget {
  final String chatTitle;

  const ChatScreen({super.key, required this.chatTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground, // Fondo de pantalla
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          chatTitle,
          style: const TextStyle(
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BubbleMessage(
                    message: "Hola, ¿aceptas el trueque?",
                    isSender: false,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: BubbleMessage(
                    message: "Claro, ¿cuándo te viene bien?",
                    isSender: true,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BubbleMessage(
                    message: "Mañana por la tarde, ¿te va bien?",
                    isSender: false,
                  ),
                ),
              ],
            ),
          ),
        Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Escribe un mensaje...",
            hintStyle: const TextStyle(color: AppColors.textSecondary), // Added const
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25), // BorderRadius can't be const
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      IconButton(
        icon: const Icon(Icons.send, color: AppColors.iconSelected), // Added const
        onPressed: () {
          // Lógica para enviar mensaje

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BubbleMessage extends StatelessWidget {
  final String message;
  final bool isSender;

  const BubbleMessage({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isSender ? AppColors.iconSelected : AppColors.cardBackground, // Morado si es el remitente
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isSender ? const Radius.circular(20) : Radius.zero,
          bottomRight: isSender ? Radius.zero : const Radius.circular(20),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: isSender ? AppColors.textLight : AppColors.textDark, // Texto blanco si es morado
        ),
      ),
    );
  }
}
