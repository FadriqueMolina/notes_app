import 'package:flutter/material.dart';
import 'package:notes_app/business/models/note_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchProvider with ChangeNotifier {
  final _supabaseClient = Supabase.instance.client;
  List<Note> _listOfNotes = [];

  List<Note> get listOfNotes => _listOfNotes;
  Future<void> makeSearch(String title) async {
    User? user = _supabaseClient.auth.currentUser;

    if (user == null) {
      throw Exception("Usuario no loggeado");
    }

    final response = await _supabaseClient
        .from("notes")
        .select()
        .eq("user_id", user.id)
        .eq("title", title);

    _listOfNotes =
        response.map((note) {
          return Note.fromJson(note);
        }).toList();
    notifyListeners();
  }
}
