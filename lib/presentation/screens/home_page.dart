import 'package:flutter/material.dart';
import 'package:notes_app/business/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.grey[700]),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.list),
            color: Colors.grey[700],
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, noteProvider, child) {
          return const Center(
            child: Text(
              "Tu bandeja de notas esta vacia.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddNoteDialog(context);
        },
        backgroundColor: Colors.grey[500],
        child: const Icon(Icons.add, size: 35, color: Colors.black),
      ),
    );
  }

  void showAddNoteDialog(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Agregar nota"),
            content: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Agregar",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
    );
  }
}
