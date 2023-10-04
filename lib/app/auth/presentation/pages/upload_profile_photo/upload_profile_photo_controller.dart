import 'package:flutter_riverpod/flutter_riverpod.dart';


class UploadProfilePhotoController extends StateNotifier<UploadProfilePhotoState>{

  UploadProfilePhotoController(this.ref) : super(UploadProfilePhotoInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = UploadProfilePhotoLoading();

      state = UploadProfilePhotoSuccess();
    } catch (e) {
      state = UploadProfilePhotoError(e.toString());
    }
  }


}


final upload_profile_photoProvider =
    StateNotifierProvider<UploadProfilePhotoController, UploadProfilePhotoState>((ref) {
  return UploadProfilePhotoController(ref);
});



 abstract class UploadProfilePhotoState {}

 class UploadProfilePhotoInitial extends UploadProfilePhotoState {}

 class UploadProfilePhotoLoading extends UploadProfilePhotoState {}

 class UploadProfilePhotoSuccess extends UploadProfilePhotoState {}

 class UploadProfilePhotoError extends UploadProfilePhotoState {
   final String message;

   UploadProfilePhotoError(this.message);
 }
