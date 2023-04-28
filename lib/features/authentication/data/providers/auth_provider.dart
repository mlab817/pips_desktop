import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/user/user.dart';

class AuthModel {
  final User? user;
  final bool isLoggedIn;

  AuthModel({
    this.user,
    required this.isLoggedIn,
  });
}

class AuthState extends StateNotifier<AuthModel> {
  // initialize user with
  AuthState() : super(AuthModel(isLoggedIn: false));

  void setCurrentUser(User user) {
    state = AuthModel(isLoggedIn: true, user: user);
  }

  void clearCurrentUser() {
    state = AuthModel(isLoggedIn: false, user: null);
  }
}

final authState =
    StateNotifierProvider<AuthState, AuthModel>((ref) => AuthState());
