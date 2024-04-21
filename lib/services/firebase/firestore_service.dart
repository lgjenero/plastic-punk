import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plastic_punk/services/auth/auth_service.dart';
import 'package:plastic_punk/services/user/user_data.dart';
import 'package:plastic_punk/state/game/data/game_state_saved_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_service.g.dart';

@riverpod
FirestoreService firestoreService(FirestoreServiceRef ref) {
  return FirestoreService(firestore: FirebaseFirestore.instance);
}

class FirestoreService {
  final FirebaseFirestore firestore;

  CollectionReference<GameStateSavedData>? get _savedGameRef {
    final userId = AuthService(auth: FirebaseAuth.instance).getUserId();
    if (userId == null) return null;

    return FirebaseFirestore.instance.collection('users').doc(userId).collection('saves').withConverter(
          fromFirestore: (snapshot, _) => GameStateSavedData.fromJson({'slot': snapshot.id, ...snapshot.data()!}),
          toFirestore: (data, _) => data.toJson()
            ..remove('slot')
            ..['createdAt'] = FieldValue.serverTimestamp(),
        );
  }

  DocumentReference<GameStateSavedData>? _savedGameSlotRef(String slot) {
    return _savedGameRef?.doc(slot);
  }

  CollectionReference<UserData>? get _usersRef {
    return FirebaseFirestore.instance.collection('users').withConverter(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (data, _) => data.toJson(),
        );
  }

  DocumentReference<UserData>? get _userRef {
    final userId = AuthService(auth: FirebaseAuth.instance).getUserId();
    if (userId == null) return null;

    return _usersRef?.doc(userId);
  }

  FirestoreService({required this.firestore});

  Future<bool> saveGame(GameStateSavedData saveData, String slot) async {
    final ref = _savedGameSlotRef(slot);
    if (ref == null) return false;

    bool saved = false;
    try {
      ref.set(saveData);
      saved = true;
    } catch (_) {}

    return saved;
  }

  Future<GameStateSavedData?> loadGame(String slot) async {
    final ref = _savedGameSlotRef(slot);
    if (ref == null) return null;

    try {
      final snapshot = await ref.get();
      return snapshot.data();
    } catch (_) {}

    return null;
  }

  Future<List<GameStateSavedData>> loadAllGames() async {
    final saves = <GameStateSavedData>[];
    try {
      final snapshots = await _savedGameRef?.get();
      if (snapshots != null) {
        for (final doc in snapshots.docs) {
          try {
            saves.add(doc.data());
          } catch (_) {}
        }
      }
    } catch (_) {}

    return saves;
  }

  Future<UserData?> getUserData() async {
    final ref = _userRef;
    if (ref == null) return null;

    try {
      final snapshot = await ref.get();
      return snapshot.data();
    } catch (_) {}
    return null;
  }

  Future<bool> setUserData(UserData data) async {
    final ref = _userRef;
    if (ref == null) return false;

    bool saved = false;
    try {
      ref.set(data);
      saved = true;
    } catch (_) {}

    return saved;
  }
}
