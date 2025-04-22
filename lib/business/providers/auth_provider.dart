import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  //Supabase instance
  final _supabaseClient = Supabase.instance.client;
  User? _currentUser;
  String? _errorMessage;
  String get errorMessage => _errorMessage ?? "";
  User? get currentUser => _currentUser;
  Stream<AuthState> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange;
  AuthProvider() {
    _currentUser = _supabaseClient.auth.currentUser;
    _setupAuthListener();
  }

  void _setupAuthListener() {
    _supabaseClient.auth.onAuthStateChange.listen((data) {
      _currentUser = data.session?.user;
      notifyListeners();
    });
  }

  //Login
  Future<void> login(String email, String password) async {
    try {
      _errorMessage = null;
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      _currentUser = response.user;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  //Register
  Future<void> register(String email, String password) async {
    try {
      _errorMessage = null;
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      _currentUser = response.user;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  //Logout
  Future<void> logout() async {
    await _supabaseClient.auth.signOut();
    _currentUser = null;
    notifyListeners();
  }
}
