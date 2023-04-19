import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isAuthenticated = false;
  bool _isSigningIn = false;
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;
  bool get isAuthenticated => _isAuthenticated;
  bool get isSigningIn => _isSigningIn;

  void _setIsAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  void _setIsSigningIn(bool value) {
    _isSigningIn = value;
    notifyListeners();
  }

  Future googleLogin() async {
    _setIsSigningIn(true);
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      _setIsAuthenticated(true);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _setIsSigningIn(false);
    }
  }

  Future logout() async {
    try {
      await googleSignIn.disconnect();
      await _auth.signOut();
      _user = null;
      _setIsAuthenticated(false);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
