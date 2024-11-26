// lib/views/Books/trade_proposal_screen.dart
import 'package:flutter/material.dart';
import '../../models/book_model.dart';
import '../../styles/colors.dart';
import 'add_book_dialog.dart';

class TradeProposalScreen extends StatefulWidget {
  final List<Book> availableBooks;

  const TradeProposalScreen({super.key, required this.availableBooks});

  @override
  TradeProposalScreenState createState() => TradeProposalScreenState();
}

class TradeProposalScreenState extends State<TradeProposalScreen> {
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
          title: Text(
            'Confirmar Propuesta',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textPrimary),
          ),
          content: Text(
            '¿Estás seguro que deseas proponer el trueque con los libros seleccionados?',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar', style: TextStyle(color: AppColors.iconSelected)),
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
              child: Text('Confirmar', style: TextStyle(color: AppColors.textPrimary)),
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 10),
              Text('¡Propuesta realizada con éxito!',
                  textAlign: TextAlign.center, style: TextStyle(color: AppColors.textPrimary)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Aceptar', style: TextStyle(color: AppColors.iconSelected)),
            ),
          ],
        );
      },
    );
  }

  void showUndoSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Propuesta enviada', style: TextStyle(color: AppColors.textPrimary)),
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
          title: Text(
            'Confirmar Deshacer',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          content: Text(
            '¿Estás seguro que deseas deshacer la propuesta de trueque?',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar', style: TextStyle(color: AppColors.iconSelected)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.iconSelected,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Propuesta de trueque deshecha', style: TextStyle(color: AppColors.textPrimary)),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              child: Text('Deshacer', style: TextStyle(color: AppColors.textPrimary)),
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
        title: Text('Proponer Trueque', style: TextStyle(color: AppColors.textPrimary)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Selecciona los libros que deseas proponer para el trueque',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Seleccionar Todo',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
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
                itemCount: widget.availableBooks.length + 1,
                itemBuilder: (context, index) {
                  if (index == widget.availableBooks.length) {
                    return GestureDetector(
                      onTap: addNewBook,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: AppColors.iconSelected),
                            const SizedBox(width: 8),
                            Text(
                              'Agregar libro',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.iconSelected),
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
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 4,
                              offset: const Offset(2, 2),
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
                                color: AppColors.shadow,
                                image: book.thumbnail.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(book.thumbnail),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: book.thumbnail.isEmpty
                                  ? Center(
                                      child: Text(
                                        'Sin imagen',
                                        style: TextStyle(color: AppColors.textSecondary),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.title,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    book.author,
                                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
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
                backgroundColor: selectedBooks.isEmpty ? AppColors.shadow : AppColors.iconSelected,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: selectedBooks.isEmpty ? null : proposeTrade,
              child: Text(
                'Proponer Trueque',
                style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
