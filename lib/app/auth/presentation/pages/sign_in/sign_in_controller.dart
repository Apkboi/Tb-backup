import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/forgot_password_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/oauth_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_in_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/sign_in_res_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/user_dto.dart';
import 'package:triberly/app/auth/domain/services/auth_imp_service.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/services/di/di.dart';

class SignInController extends StateNotifier<SignInState> {
  SignInController(this.ref, this._authImpService) : super(SignInInitial());
  final StateNotifierProviderRef ref;

  final AuthImpService _authImpService;

  User? userData = User();

  Future<void> signIn(SignInReqDto data) async {
    try {
      state = SignInLoading();

      final response = await _authImpService.signIn(data);

      SessionManager.instance.authToken = response.data?.token ?? '';
      userData = response.data?.user;

      state = SignInSuccess();
    } catch (e) {
      state = SignInError(e.toString());
    }
  }

  Future<void> signInGoogle() async {
    try {
      state = SignInLoading();

      final response = await _authImpService.googleAuth();

      await _authImpService.oauthSignIn(OauthReqDto(
        token: response?.idToken,
        provider: 'google',
      ));

      state = SignInSuccess();
    } catch (e) {
      state = SignInError(e.toString());
    }
  }

  Future<void> signInApple() async {
    try {
      state = SignInLoading();

      final response = await _authImpService.appleAuth();

      await _authImpService.oauthSignIn(OauthReqDto(
        token: response?.authorizationCode,
        provider: 'apple',
      ));

      state = SignInSuccess();
    } catch (e) {
      state = SignInError(e.toString());
    }
  }
}

final signInProvider =
    StateNotifierProvider<SignInController, SignInState>((ref) {
  return SignInController(ref, sl());
});

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {
  final String message;

  SignInError(this.message);
}
