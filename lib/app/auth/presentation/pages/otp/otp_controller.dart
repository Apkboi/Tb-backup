import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/resend_otp_req_dto.dart';
import 'package:triberly/app/auth/domain/models/dtos/verify_otp_req_dto.dart';
import 'package:triberly/app/auth/domain/services/auth_imp_service.dart';
import 'package:triberly/core/services/di/di.dart';

class OtpController extends StateNotifier<OtpState> {
  OtpController(this.ref, this._authImpService) : super(OtpInitial());
  final StateNotifierProviderRef ref;
  final AuthImpService _authImpService;

  Future<void> resendOtp(ResendOtpReqDto data) async {
    try {
      state = ResendOtpLoading();

      final result = await _authImpService.resendOtp(data);

      state = ResendOtpSuccess(result.msg ?? '');
    } catch (e) {
      state = ResendOtpError(e.toString());
    }
  }

  Future<void> verifyOtp(VerifyOtpReqDto data) async {
    try {
      state = OtpLoading();

      final result = await _authImpService.verifyOtp(data);

      state = OtpSuccess(result.msg ?? '');
    } catch (e) {
      state = OtpError(e.toString());
    }
  }
}

final otpProvider = StateNotifierProvider<OtpController, OtpState>((ref) {
  return OtpController(ref, sl());
});

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final String message;

  OtpSuccess(this.message);
}

class OtpError extends OtpState {
  final String message;

  OtpError(this.message);
}

class ResendOtpLoading extends OtpState {}

class ResendOtpSuccess extends OtpState {
  final String message;
  ResendOtpSuccess(this.message);
}

class ResendOtpError extends OtpState {
  final String message;
  ResendOtpError(this.message);
}
