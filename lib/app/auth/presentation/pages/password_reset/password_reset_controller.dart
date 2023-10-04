import 'package:flutter_riverpod/flutter_riverpod.dart';


class PasswordResetController extends StateNotifier<PasswordResetState>{

  PasswordResetController(this.ref) : super(PasswordResetInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = PasswordResetLoading();

      state = PasswordResetSuccess();
    } catch (e) {
      state = PasswordResetError(e.toString());
    }
  }


}


final password_resetProvider =
    StateNotifierProvider<PasswordResetController, PasswordResetState>((ref) {
  return PasswordResetController(ref);
});



 abstract class PasswordResetState {}

 class PasswordResetInitial extends PasswordResetState {}

 class PasswordResetLoading extends PasswordResetState {}

 class PasswordResetSuccess extends PasswordResetState {}

 class PasswordResetError extends PasswordResetState {
   final String message;

   PasswordResetError(this.message);
 }
