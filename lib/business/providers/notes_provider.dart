import 'package:flutter/material.dart';
import 'package:notes_app/business/models/note_model.dart';

class NotesProvider with ChangeNotifier {
  //TODO: En la siguiente actualizacion voy a migrar este provider al uso de Supabase

  //Lista de notas
  final List<Note> _noteList = [];

  List<Note> get noteList => _noteList;

  //Agregar una nota
  void addNote(Note noteToAdd) {
    _noteList.add(noteToAdd);
    notifyListeners();
  }

  //Actualizar una nota
  void updateNote(String id, Note noteToUpdate) {
    int index = _noteList.indexWhere((note) => note.id == id);

    if (index != -1) {
      _noteList[index] = noteToUpdate;
    }

    notifyListeners();
  }

  //Borrar una nota
  void deleteNote(String id) {
    noteList.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
