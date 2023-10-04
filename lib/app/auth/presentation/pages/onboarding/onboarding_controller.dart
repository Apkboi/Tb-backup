import 'package:flutter_riverpod/flutter_riverpod.dart';


class OnboardingController extends StateNotifier<OnboardingState>{

  OnboardingController(this.ref) : super(OnboardingInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = OnboardingLoading();

      state = OnboardingSuccess();
    } catch (e) {
      state = OnboardingError(e.toString());
    }
  }


}


final onboardingProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>((ref) {
  return OnboardingController(ref);
});



 abstract class OnboardingState {}

 class OnboardingInitial extends OnboardingState {}

 class OnboardingLoading extends OnboardingState {}

 class OnboardingSuccess extends OnboardingState {}

 class OnboardingError extends OnboardingState {
   final String message;

   OnboardingError(this.message);
 }
