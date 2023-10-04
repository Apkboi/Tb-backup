import 'package:flutter_riverpod/flutter_riverpod.dart';


class SplashController extends StateNotifier<SplashState>{

  SplashController(this.ref) : super(SplashInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = SplashLoading();

      state = SplashSuccess();
    } catch (e) {
      state = SplashError(e.toString());
    }
  }


}


final splashProvider =
    StateNotifierProvider<SplashController, SplashState>((ref) {
  return SplashController(ref);
});



 abstract class SplashState {}

 class SplashInitial extends SplashState {}

 class SplashLoading extends SplashState {}

 class SplashSuccess extends SplashState {}

 class SplashError extends SplashState {
   final String message;

   SplashError(this.message);
 }
