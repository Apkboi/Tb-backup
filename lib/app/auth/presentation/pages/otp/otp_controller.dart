import 'package:flutter_riverpod/flutter_riverpod.dart';


class OtpController extends StateNotifier<OtpState>{

  OtpController(this.ref) : super(OtpInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = OtpLoading();

      state = OtpSuccess();
    } catch (e) {
      state = OtpError(e.toString());
    }
  }


}


final otpProvider =
    StateNotifierProvider<OtpController, OtpState>((ref) {
  return OtpController(ref);
});



 abstract class OtpState {}

 class OtpInitial extends OtpState {}

 class OtpLoading extends OtpState {}

 class OtpSuccess extends OtpState {}

 class OtpError extends OtpState {
   final String message;

   OtpError(this.message);
 }
