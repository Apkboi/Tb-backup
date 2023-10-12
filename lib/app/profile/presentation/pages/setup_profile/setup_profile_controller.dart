import 'package:flutter_riverpod/flutter_riverpod.dart';


class SetupProfileController extends StateNotifier<SetupProfileState>{

  SetupProfileController(this.ref) : super(SetupProfileInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = SetupProfileLoading();

      state = SetupProfileSuccess();
    } catch (e) {
      state = SetupProfileError(e.toString());
    }
  }


}


final setup_profileProvider =
    StateNotifierProvider<SetupProfileController, SetupProfileState>((ref) {
  return SetupProfileController(ref);
});



 abstract class SetupProfileState {}

 class SetupProfileInitial extends SetupProfileState {}

 class SetupProfileLoading extends SetupProfileState {}

 class SetupProfileSuccess extends SetupProfileState {}

 class SetupProfileError extends SetupProfileState {
   final String message;

   SetupProfileError(this.message);
 }
