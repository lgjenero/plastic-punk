import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plastic_punk/services/auth/auth_service.dart';
import 'package:plastic_punk/services/firebase/firestore_service.dart';
import 'package:plastic_punk/services/location/ip_location_service.dart';
import 'package:plastic_punk/services/user/user_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_service.g.dart';

class UserServiceData {
  final UserData userData;
  final bool loaded;

  const UserServiceData({required this.userData, required this.loaded});

  UserServiceData copyWith({UserData? userData, bool? loaded}) {
    return UserServiceData(
      userData: userData ?? this.userData,
      loaded: loaded ?? this.loaded,
    );
  }
}

@Riverpod(keepAlive: true)
class UserService extends _$UserService {
  @override
  UserServiceData build() {
    initialize();

    return const UserServiceData(userData: UserData(), loaded: true);
  }

  static const userDataKey = 'user_data';

  void initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(userDataKey) ?? '{}';
    final user = UserData.fromJson(jsonDecode(userData));
    state = state.copyWith(userData: user);

    await loadUserDataFromFirestore();

    if (!user.countryCode.isValidCountryCode) {
      final location = await ref.read(ipLocationServiceProvider).getIpLocation();
      final countryCode = location?.countryCode2?.toUpperCase() ?? 'UN';
      updateCountryCode(countryCode);
    }

    state = state.copyWith(loaded: true);
  }

  Future<String?> login(String email, String password) async {
    state = state.copyWith(loaded: false);
    final result = await AuthService(auth: FirebaseAuth.instance).login(email, password);
    if (result == null) {
      await loadUserDataFromFirestore();
    }
    state = state.copyWith(loaded: true);
    return result;
  }

  Future<String?> signUp(String email, String password) async {
    state = state.copyWith(loaded: false);
    final result = await AuthService(auth: FirebaseAuth.instance).signUp(email, password);
    if (result == null) {
      await loadUserDataFromFirestore();
    }
    state = state.copyWith(loaded: true);
    return result;
  }

  Future<String?> logout() => AuthService(auth: FirebaseAuth.instance).logout();

  Future<void> loadUserDataFromFirestore() async {
    final userId = AuthService(auth: FirebaseAuth.instance).getUserId();
    if (userId != null) {
      final user = await FirestoreService(firestore: FirebaseFirestore.instance).getUserData();

      final userData = state.userData;
      UserData merged = userData;
      if (user != null) {
        merged = merged.copyWith(
          countryCode: user.countryCode.isValidCountryCode ? user.countryCode : userData.countryCode,
          flag: user.flag,
          finishedLevel: user.finishedLevel > userData.finishedLevel ? user.finishedLevel : userData.finishedLevel,
          achievements:
              user.achievements.length > userData.achievements.length ? user.achievements : userData.achievements,
          introShown: user.introShown || userData.introShown,
          onboardingTooltipsShown: user.onboardingTooltipsShown.length > userData.onboardingTooltipsShown.length
              ? user.onboardingTooltipsShown
              : userData.onboardingTooltipsShown,
        );
      }

      state = state.copyWith(userData: merged);
      storeUserData();
    }
  }

  void storeUserData() {
    final userData = state.userData;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(userDataKey, jsonEncode(userData.toJson()));
    });

    final userId = AuthService(auth: FirebaseAuth.instance).getUserId();
    if (userId != null) {
      FirestoreService(firestore: FirebaseFirestore.instance).setUserData(userData);
    }
  }

  void levelFinished(int level) {
    if (state.userData.finishedLevel >= level) return;

    final userData = state.userData.copyWith(finishedLevel: level);
    state = state.copyWith(userData: userData);

    storeUserData();
  }

  void addAchievement(String achievement) {
    final userData = state.userData.copyWith(achievements: [...state.userData.achievements, achievement]);
    state = state.copyWith(userData: userData);

    storeUserData();
  }

  void setIntroShown() {
    final userData = state.userData.copyWith(introShown: true);
    state = state.copyWith(userData: userData);

    storeUserData();
  }

  void setOnboardingTooltipShown(OnboardingTooltip tooltip) {
    final userData = state.userData.copyWith(onboardingTooltipsShown: {
      ...state.userData.onboardingTooltipsShown,
      tooltip,
    });
    state = state.copyWith(userData: userData);

    storeUserData();
  }

  void updateCountryCode(String countryCode) {
    final userData = state.userData.copyWith(countryCode: countryCode);
    state = state.copyWith(userData: userData);

    storeUserData();
  }

  void updateFlag(String flagCode) {
    final userData = state.userData.copyWith(flag: flagCode);
    state = state.copyWith(userData: userData);

    storeUserData();
  }
}

const _invalidCountryCodes = ['UN', 'PI', 'EU'];

extension StringUtils on String {
  bool get isValidCountryCode {
    return isNotEmpty && _invalidCountryCodes.contains(this) == false;
  }
}
