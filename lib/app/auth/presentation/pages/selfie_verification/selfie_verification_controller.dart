import 'package:flutter_riverpod/flutter_riverpod.dart';


class SelfieVerificationController extends StateNotifier<SelfieVerificationState>{

  SelfieVerificationController(this.ref) : super(SelfieVerificationInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = SelfieVerificationLoading();

      state = SelfieVerificationSuccess();
    } catch (e) {
      state = SelfieVerificationError(e.toString());
    }
  }


}


final selfie_verificationProvider =
    StateNotifierProvider<SelfieVerificationController, SelfieVerificationState>((ref) {
  return SelfieVerificationController(ref);
});



 abstract class SelfieVerificationState {}

 class SelfieVerificationInitial extends SelfieVerificationState {}

 class SelfieVerificationLoading extends SelfieVerificationState {}

 class SelfieVerificationSuccess extends SelfieVerificationState {}

 class SelfieVerificationError extends SelfieVerificationState {
   final String message;

   SelfieVerificationError(this.message);
 }
