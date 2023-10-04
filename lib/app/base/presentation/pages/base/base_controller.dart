import 'package:flutter_riverpod/flutter_riverpod.dart';


class BaseController extends StateNotifier<BaseState>{

  BaseController(this.ref) : super(BaseInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = BaseLoading();

      state = BaseSuccess();
    } catch (e) {
      state = BaseError(e.toString());
    }
  }


}


final baseProvider =
    StateNotifierProvider<BaseController, BaseState>((ref) {
  return BaseController(ref);
});



 abstract class BaseState {}

 class BaseInitial extends BaseState {}

 class BaseLoading extends BaseState {}

 class BaseSuccess extends BaseState {}

 class BaseError extends BaseState {
   final String message;

   BaseError(this.message);
 }
