import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/business/models/note_model.dart';
import 'package:notes_app/business/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Note currentNote;

  const NoteDetailsScreen({super.key, required this.currentNote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentNote.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              //TODO: Implementar actualizado de la nota desde este lugar
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              //TODO: Implementar borrado de la nota desde este lugar
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                DateFormat('dd/MM/yyyy HH:mm').format(currentNote.lastEdited),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                currentNote.content,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
