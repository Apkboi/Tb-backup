import 'package:flutter_riverpod/flutter_riverpod.dart';


class CommunityController extends StateNotifier<CommunityState>{

  CommunityController(this.ref) : super(CommunityInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = CommunityLoading();

      state = CommunitySuccess();
    } catch (e) {
      state = CommunityError(e.toString());
    }
  }


}


final communityProvider =
    StateNotifierProvider<CommunityController, CommunityState>((ref) {
  return CommunityController(ref);
});



 abstract class CommunityState {}

 class CommunityInitial extends CommunityState {}

 class CommunityLoading extends CommunityState {}

 class CommunitySuccess extends CommunityState {}

 class CommunityError extends CommunityState {
   final String message;

   CommunityError(this.message);
 }
