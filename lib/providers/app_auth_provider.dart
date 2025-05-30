import 'dart:async';
import 'package:ecommerce/models/carts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui_auth;
import 'package:flutter/material.dart';

class AppAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppAuthProvider() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  User? _user;
  User? get user => _user;

  String? get displayName => _user?.displayName;
  String? get email => _user?.email;

  bool _emailVerified = false;
  bool get emailVerified => _emailVerified;

  List<Cart> _cart = [];
  List<Cart> get cart => _cart;
  bool _isInitialized = false;

  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get isInitialized => _isInitialized;
  Future<void> init() async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    ui_auth.FirebaseUIAuth.configureProviders([ui_auth.EmailAuthProvider()]);

    FirebaseAuth.instance.userChanges().listen((user) {
      _user = user;
      if (user != null) {
        _loggedIn = true;
        _emailVerified = user.emailVerified;
        _isInitialized = true;
      } else {
        _loggedIn = false;
        _emailVerified = false;
        _isInitialized = true;
        _cart = [];

        notifyListeners();
      }
    });
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      final user = _auth.currentUser;
      if (user != null) {
        _loggedIn = true;
        _emailVerified = user.emailVerified;
        notifyListeners();
      }

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setError(e.message ?? 'An error occurred during sign in');
      return false;
    } catch (e) {
      _setError('An unexpected error occurred');
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String name) async {
    _setLoading(true);
    _clearError();

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(name);
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _setError('Энэ имэйлээр бүртгэгдсэн хэрэглэгч аль хэдийн байна.');
      } else {
        _setError(e.message ?? 'Бүртгүүлэх явцад алдаа гарлаа.');
      }
      return false;
    } catch (e) {
      _setError('Гэнэтийн алдаа гарлаа.');
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      _setError('Error signing out');
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _setLoading(false);
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
