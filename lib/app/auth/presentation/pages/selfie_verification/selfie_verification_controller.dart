import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/app/auth/domain/services/account_imp_service.dart';
import 'package:triberly/app/auth/domain/services/auth_imp_service.dart';
import 'package:triberly/core/services/di/di.dart';

class SelfieVerificationController
    extends StateNotifier<SelfieVerificationState> {
  SelfieVerificationController(this.ref, this._accountImpService)
      : super(SelfieVerificationInitial());
  final StateNotifierProviderRef ref;
  final AccountImpService _accountImpService;

  Future<void> caller(UpdateProfileReqDto data) async {
    try {
      state = SelfieVerificationLoading();

      await _accountImpService.updateProfile(data);
      state = SelfieVerificationSuccess();
    } catch (e) {
      state = SelfieVerificationError(e.toString());
    }
  }
}

final selfieVerificationProvider = StateNotifierProvider<
    SelfieVerificationController, SelfieVerificationState>((ref) {
  return SelfieVerificationController(ref, sl());
});

abstract class SelfieVerificationState {}

class SelfieVerificationInitial extends SelfieVerificationState {}

class SelfieVerificationLoading extends SelfieVerificationState {}

class SelfieVerificationSuccess extends SelfieVerificationState {}

class SelfieVerificationError extends SelfieVerificationState {
  final String message;

  SelfieVerificationError(this.message);
}
