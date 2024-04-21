import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@riverpod
AuthService authService(AuthServiceRef _) {
  return AuthService(auth: FirebaseAuth.instance);
}

@riverpod
Stream<User?> loggedInUser(LoggedInUserRef ref) {
  StreamController<User?> controller = StreamController();
  StreamSubscription<User?>? subscription;

  ref.onDispose(() {
    controller.close();
    subscription?.cancel();
  });

  controller.add(FirebaseAuth.instance.currentUser);

  subscription = FirebaseAuth.instance.authStateChanges().listen((event) {
    controller.add(event);
  });

  return controller.stream;
}

class AuthService {
  final FirebaseAuth auth;

  AuthService({required this.auth});

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  String? getUserId() {
    return auth.currentUser?.uid;
  }

  Future<String?> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (error) {
      if (error is FirebaseAuthException) {
        return error.message;
      }
      return 'An error occurred';
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (error) {
      if (error is FirebaseAuthException) {
        return error.message;
      }
      return 'An error occurred';
    }
  }

  Future<String?> logout() async {
    try {
      await auth.signOut();
      return null;
    } catch (error) {
      if (error is FirebaseAuthException) {
        return error.message;
      }
      return 'An error occurred';
    }
  }
}
