import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/services/account_imp_service.dart';

import '../../../../core/services/di/di.dart';

class SecurityController extends StateNotifier<SecurityState> {
  SecurityController(this.ref, this._accountImpService)
      : super(ProfileInitial());
  final StateNotifierProviderRef ref;
  final AccountImpService _accountImpService;

  Future<void> caller() async {
    // try {
    //   state = ProfileLoading();
    //
    //   state = ProfileSuccess();
    // } catch (e) {
    //   state = ProfileError(e.toString());
    // }
  }

  Future<void> deleteAccount(String reason) async {
    try {
      state = DeleteAccountLoading();
      var res = await _accountImpService.deleteAccount(reason);

      state = DeleteAccountSuccess();
    } catch (e) {
      state = DeleteAccountError(e.toString());
    }
  }
}

final securityProvider =
    StateNotifierProvider<SecurityController, SecurityState>((ref) {
  return SecurityController(ref, sl.get());
});

abstract class SecurityState {}

class ProfileInitial extends SecurityState {}

class ProfileLoading extends SecurityState {}

class ProfileSuccess extends SecurityState {}

class ProfileError extends SecurityState {
  final String message;

  ProfileError(this.message);
}

class DeleteAccountLoading extends SecurityState {}

class DeleteAccountSuccess extends SecurityState {}

class DeleteAccountError extends SecurityState {
  final String message;

  DeleteAccountError(this.message);
}
