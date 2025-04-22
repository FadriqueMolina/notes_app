import 'package:flutter/material.dart';
import 'package:notes_app/business/models/note_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesProvider with ChangeNotifier {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  //Agregar una nota
  Future<void> addNote(Note noteToAdd) async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        throw Exception("Usuario no autenticado");
      }

      final response =
          await _supabaseClient.from("notes").insert({
            "title": noteToAdd.title,
            "content": noteToAdd.content,
            "user_id": user.id, // Añadir esto es crucial
            "last_edited": DateTime.now().toIso8601String(),
          }).select();

      notifyListeners();
    } catch (e) {
      throw Exception("Error al crear la nota: $e");
    }
  }

  Future<List<Note>> fetchNotes() async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) {
      return [];
    }
    final response = await _supabaseClient
        .from("notes")
        .select()
        .eq("user_id", user.id)
        .order("last_edited", ascending: false);

    return response.map((json) => Note.fromJson(json)).toList();
  }

  //Actualizar una nota
  Future<void> updateNote(String id, Note noteToUpdate) async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        throw Exception("Usuario no autenticado");
      }

      final response =
          await _supabaseClient
              .from("notes")
              .update(noteToUpdate.toJson())
              .eq("user_id", user.id)
              .select();

      notifyListeners();
    } catch (e) {
      throw Exception("Error al actualizar la nota: $e");
    }
  }

  //Borrar una nota
  Future<void> deleteNote(String id) async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        throw Exception("Usuario no autenticado");
      }

      final response =
          await _supabaseClient
              .from("notes")
              .delete()
              .eq("user_id", user.id)
              .eq("id", id)
              .select();
      notifyListeners();
    } catch (e) {
      throw Exception("Error al borrar la nota: $e");
    }
  }
}
