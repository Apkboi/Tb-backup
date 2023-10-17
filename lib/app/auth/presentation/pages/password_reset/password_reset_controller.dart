import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/forgot_password_req_dto.dart';
import 'package:triberly/app/auth/domain/services/auth_imp_service.dart';
import 'package:triberly/core/services/di/di.dart';

class PasswordResetController extends StateNotifier<PasswordResetState> {
  PasswordResetController(this.ref, this._authImpService)
      : super(PasswordResetInitial());
  final StateNotifierProviderRef ref;

  final AuthImpService _authImpService;

  Future<void> caller() async {
    try {
      state = PasswordResetLoading();

      state = PasswordResetSuccess();
    } catch (e) {
      state = PasswordResetError(e.toString());
    }
  }

  Future<void> forgotPasswordinit(ForgotPasswordReqDto data) async {
    try {
      state = ForgotPasswordLoading();

      final response = await _authImpService.forgotPassword(data);

      state = ForgotPasswordSuccess(response.msg ?? 'Successful');
    } catch (e) {
      state = ForgotPasswordError(e.toString());
    }
  }
}

final passwordResetProvider =
    StateNotifierProvider<PasswordResetController, PasswordResetState>((ref) {
  return PasswordResetController(ref, sl());
});

abstract class PasswordResetState {}

class PasswordResetInitial extends PasswordResetState {}

class PasswordResetLoading extends PasswordResetState {}

class PasswordResetSuccess extends PasswordResetState {}

class PasswordResetError extends PasswordResetState {
  final String message;

  PasswordResetError(this.message);
}

class ForgotPasswordLoading extends PasswordResetState {}

class ForgotPasswordSuccess extends PasswordResetState {
  final String message;
  ForgotPasswordSuccess(this.message);
}

class ForgotPasswordError extends PasswordResetState {
  final String message;
  ForgotPasswordError(this.message);
}
