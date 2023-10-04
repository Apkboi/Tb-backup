import 'package:flutter_riverpod/flutter_riverpod.dart';


class ProfileDetailsController extends StateNotifier<ProfileDetailsState>{

  ProfileDetailsController(this.ref) : super(ProfileDetailsInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = ProfileDetailsLoading();

      state = ProfileDetailsSuccess();
    } catch (e) {
      state = ProfileDetailsError(e.toString());
    }
  }


}


final profile_detailsProvider =
    StateNotifierProvider<ProfileDetailsController, ProfileDetailsState>((ref) {
  return ProfileDetailsController(ref);
});



 abstract class ProfileDetailsState {}

 class ProfileDetailsInitial extends ProfileDetailsState {}

 class ProfileDetailsLoading extends ProfileDetailsState {}

 class ProfileDetailsSuccess extends ProfileDetailsState {}

 class ProfileDetailsError extends ProfileDetailsState {
   final String message;

   ProfileDetailsError(this.message);
 }
