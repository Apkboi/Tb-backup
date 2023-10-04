import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpController extends StateNotifier<SignUpState> {
  SignUpController(this.ref) : super(SignUpInitial());
  final StateNotifierProviderRef ref;

  String _userEmail = '';
  String _userPhoneNumber = '';

  (String, String) get getUserData => (_userEmail, _userPhoneNumber);

  void setUserData(String email, String phoneNumber) {
    _userEmail = email;
    _userPhoneNumber = phoneNumber;
  }

  Future<void> caller() async {
    try {
      state = SignUpLoading();

      state = SignUpSuccess();
    } catch (e) {
      state = SignUpError(e.toString());
    }
  }
}

final signupProvider =
    StateNotifierProvider<SignUpController, SignUpState>((ref) {
  return SignUpController(ref);
});

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String message;

  SignUpError(this.message);
}
