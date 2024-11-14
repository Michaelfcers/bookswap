// lib/views/Books/trade_proposal_screen.dart
import 'package:flutter/material.dart';
import '../../models/book_model.dart';
import '../../styles/colors.dart';
import 'add_book_dialog.dart'; // Diálogo de agregar libro

class TradeProposalScreen extends StatefulWidget {
  final List<Book> availableBooks;

  const TradeProposalScreen({super.key, required this.availableBooks});

  @override
  TradeProposalScreenState createState() => TradeProposalScreenState(); // Clase de estado pública
}

class TradeProposalScreenState extends State<TradeProposalScreen> { // Clase de estado pública
  final List<Book> selectedBooks = [];
  bool selectAll = false;

  void toggleBookSelection(Book book) {
    setState(() {
      if (selectedBooks.contains(book)) {
        selectedBooks.remove(book);
      } else {
        selectedBooks.add(book);
      }
      selectAll = selectedBooks.length == widget.availableBooks.length;
    });
  }

  void toggleSelectAll() {
    setState(() {
      selectAll = !selectAll;
      if (selectAll) {
        selectedBooks.addAll(widget.availableBooks);
      } else {
        selectedBooks.clear();
      }
    });
  }

  Future<void> addNewBook() async {
    final Book? newBook = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddBookDialog();
      },
    );

    if (newBook != null) {
      setState(() {
        widget.availableBooks.add(newBook);
      });
    }
  }

  void proposeTrade() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          title: const Text(
            'Confirmar Propuesta',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textDark),
          ),
          content: const Text(
            '¿Estás seguro que deseas proponer el trueque con los libros seleccionados?',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar', style: TextStyle(color: AppColors.iconSelected)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconSelected,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                showSuccessDialog();
                showUndoSnackbar();
              },
              child: const Text('Confirmar', style: TextStyle(color: AppColors.textLight)),
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 10),
              Text('¡Propuesta realizada con éxito!', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textDark)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Aceptar', style: TextStyle(color: AppColors.iconSelected)),
            ),
          ],
        );
      },
    );
  }

  void showUndoSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Enviado', style: TextStyle(color: AppColors.textLight)),
        backgroundColor: AppColors.primary,
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: showUndoConfirmationDialog,
          textColor: AppColors.iconSelected,
        ),
      ),
    );
  }

  void showUndoConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          title: const Text(
            'Confirmar Deshacer',
            style: TextStyle(color: AppColors.textDark),
          ),
          content: const Text(
            '¿Estás seguro que deseas deshacer la propuesta de trueque?',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar', style: TextStyle(color: AppColors.iconSelected)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconSelected,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Propuesta de trueque deshecha', style: TextStyle(color: AppColors.textLight)),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              child: const Text('Deshacer', style: TextStyle(color: AppColors.textLight)),
            ),
          ],
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
        title: const Text('Proponer Trueque', style: TextStyle(color: AppColors.textLight)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textLight),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Selecciona los libros que deseas proponer para el trueque',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textLight),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Seleccionar Todo',
                  style: TextStyle(color: AppColors.textLight, fontSize: 16),
                ),
                Checkbox(
                  value: selectAll,
                  onChanged: (_) => toggleSelectAll(),
                  activeColor: AppColors.iconSelected,
                  checkColor: AppColors.cardBackground,
                ),
              ],
            ),
            Expanded(
  child: ListView.builder(
    itemCount: widget.availableBooks.length + 1, // +1 para el botón de agregar
    itemBuilder: (context, index) {
      if (index == widget.availableBooks.length) {
        // Botón para agregar un nuevo libro
        return GestureDetector(
          onTap: addNewBook,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: AppColors.iconSelected),
              SizedBox(width: 8),
              Text(
                'Agregar libro',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.iconSelected,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        final book = widget.availableBooks[index];
        final isSelected = selectedBooks.contains(book);

        
                    return GestureDetector(
                      onTap: () => toggleBookSelection(book),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade300,
                                image: book.thumbnail.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(book.thumbnail),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: book.thumbnail.isEmpty
                                  ? const Center(child: Text('Sin imagen'))
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.title,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    book.author,
                                    style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                            Checkbox(
                              value: isSelected,
                              activeColor: AppColors.iconSelected,
                              onChanged: (_) => toggleBookSelection(book),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedBooks.isEmpty ? Colors.grey : AppColors.iconSelected,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: selectedBooks.isEmpty ? null : proposeTrade,
              child: const Text(
                'Proponer Trueque',
                style: TextStyle(fontSize: 16, color: AppColors.textLight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
