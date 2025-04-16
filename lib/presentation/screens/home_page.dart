import 'package:flutter/material.dart';
import 'package:notes_app/business/models/note_model.dart';
import 'package:notes_app/business/providers/notes_provider.dart';
import 'package:notes_app/presentation/widgets/custom_text_field.dart';
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
            onPressed: () {
              //TODO: Accion para abrir pagina para buscar notas
            },
            icon: Icon(Icons.search, color: Colors.grey[700]),
          ),
          IconButton(
            onPressed: () {
              //TODO: Accion para mostrar las notas en lista o en grid
            },
            icon: const Icon(Icons.list),
            color: Colors.grey[700],
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        //Esto es funcional porque muestra el texto o la lista de elementos, pero me gustaria alguna alternativa con mejor visibilidad, que se pueda leer mejor (Probablemente un builder)
        builder: (context, noteProvider, child) {
          if (noteProvider.noteList.isEmpty) {
            return const Center(
              child: Text(
                "Tu bandeja de notas esta vacia.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return Center(
              child: ListView.builder(
                itemCount: noteProvider.noteList.length,
                itemBuilder: (context, index) {
                  final note = noteProvider.noteList[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                  );
                },
              ),
            );
          }
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
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    //TODO: Crear un form para validar las entradas para el titulo y el contenido
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Agregar nota"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(hint: "Titulo", controller: titleController),
                SizedBox(height: 10),
                CustomTextField(
                  hint: "Contenido",
                  controller: contentController,
                ),
              ],
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
                  Note noteToAdd = Note(
                    id: DateTime.now().toString(),
                    title: titleController.text,
                    content: contentController.text,
                    lastEdited: DateTime.now(),
                  );
                  notesProvider.addNote(noteToAdd);
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
