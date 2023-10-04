import 'package:flutter_riverpod/flutter_riverpod.dart';


class SignInController extends StateNotifier<SignInState>{

  SignInController(this.ref) : super(SignInInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = SignInLoading();

      state = SignInSuccess();
    } catch (e) {
      state = SignInError(e.toString());
    }
  }


}


final sign_inProvider =
    StateNotifierProvider<SignInController, SignInState>((ref) {
  return SignInController(ref);
});



 abstract class SignInState {}

 class SignInInitial extends SignInState {}

 class SignInLoading extends SignInState {}

 class SignInSuccess extends SignInState {}

 class SignInError extends SignInState {
   final String message;

   SignInError(this.message);
 }
