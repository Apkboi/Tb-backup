import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeController extends StateNotifier<HomeState>{

  HomeController(this.ref) : super(HomeInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = HomeLoading();

      state = HomeSuccess();
    } catch (e) {
      state = HomeError(e.toString());
    }
  }


}


final homeProvider =
    StateNotifierProvider<HomeController, HomeState>((ref) {
  return HomeController(ref);
});



 abstract class HomeState {}

 class HomeInitial extends HomeState {}

 class HomeLoading extends HomeState {}

 class HomeSuccess extends HomeState {}

 class HomeError extends HomeState {
   final String message;

   HomeError(this.message);
 }
