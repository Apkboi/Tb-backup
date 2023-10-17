import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_up_req_dto.dart';
import 'package:triberly/app/auth/domain/services/auth_imp_service.dart';
import 'package:triberly/core/services/di/di.dart';

class SignUpController extends StateNotifier<SignUpState> {
  SignUpController(this.ref, this._authImpService) : super(SignUpInitial());
  final StateNotifierProviderRef ref;

  final AuthImpService _authImpService;

  String _userEmail = '';
  String _userPhoneNumber = '';

  (String, String) get getUserData => (_userEmail, _userPhoneNumber);

  void setUserData(String email, String phoneNumber) {
    _userEmail = email;
    _userPhoneNumber = phoneNumber;
  }

  Future<void> signUp(SignUpReqDto data) async {
    try {
      state = SignUpLoading();

      await _authImpService.signUp(data);

      state = SignUpSuccess();
    } catch (e) {
      state = SignUpError(e.toString());
    }
  }

  Future<void> signInGoogle() async {
    try {
      state = SignUpLoading();

      final response = await _authImpService.googleAuth();

      state = SignUpSuccess();
    } catch (e) {
      state = SignUpError(e.toString());
    }
  }

  Future<void> signInApple() async {
    try {
      state = SignUpLoading();

      final response = await _authImpService.appleAuth();

      state = SignUpSuccess();
    } catch (e) {
      state = SignUpError(e.toString());
    }
  }
}

final signupProvider =
    StateNotifierProvider<SignUpController, SignUpState>((ref) {
  return SignUpController(ref, sl());
});

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String message;

  SignUpError(this.message);
}
