import 'package:flutter/material.dart';
import 'package:notes_app/business/models/note_model.dart';
import 'package:notes_app/business/providers/notes_provider.dart';
import 'package:notes_app/presentation/screens/note_details_screen.dart';
import 'package:notes_app/presentation/widgets/custom_list_card.dart';
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
        builder: (context, noteProvider, child) {
          if (noteProvider.noteList.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.note_add, size: 50, color: Colors.grey),
                  Text(
                    "No hay notas aún",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: ListView.builder(
              itemCount: noteProvider.noteList.length,
              itemBuilder: (context, index) {
                final note = noteProvider.noteList[index];

                return CustomListCard(
                  title: note.title,
                  subtitle: note.content,
                  date: note.lastEdited,
                  onEdit: () {
                    showUpdateNoteDialog(context, note);
                  },
                  onDelete: () {
                    showDeleteNoteDialog(context, note.id);
                  },
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => NoteDetailsScreen(currentNote: note),
                      ),
                    );
                  },
                );
              },
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
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,

      builder:
          (context) => Form(
            key: formKey,
            child: AlertDialog(
              title: const Text("Agregar nota"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(hint: "Titulo", controller: titleController),
                  const SizedBox(height: 10),
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
                    if (formKey.currentState!.validate()) {
                      Note noteToAdd = Note(
                        id: DateTime.now().toString(),
                        title: titleController.text,
                        content: contentController.text,
                        lastEdited: DateTime.now(),
                      );
                      notesProvider.addNote(noteToAdd);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("¡Nota agregada!")),
                      );
                    }
                  },
                  child: const Text(
                    "Agregar",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void showUpdateNoteDialog(BuildContext context, Note note) {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder:
          (context) => Form(
            key: formKey,
            child: AlertDialog(
              title: const Text("Actualizar nota"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    hint: "Titulo",
                    controller: titleController,
                    formerText: note.title,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hint: "Contenido",
                    controller: contentController,
                    formerText: note.content,
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
                    if (formKey.currentState!.validate()) {
                      Note noteToAdd = Note(
                        id: DateTime.now().toString(),
                        title: titleController.text,
                        content: contentController.text,
                        lastEdited: DateTime.now(),
                      );
                      notesProvider.updateNote(note.id, noteToAdd);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("¡Nota actualizada!")),
                      );
                    }
                  },
                  child: const Text(
                    "Actualizar",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Future<void> showDeleteNoteDialog(BuildContext context, String id) async {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Borrar nota"),
            content: const Text("Deseas eliminar definitivamente la nota?"),

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
                  notesProvider.deleteNote(id);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Eliminar",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
    );
  }
}
