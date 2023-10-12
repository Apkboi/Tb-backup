import 'package:flutter_riverpod/flutter_riverpod.dart';


class NotificationsController extends StateNotifier<NotificationsState>{

  NotificationsController(this.ref) : super(NotificationsInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = NotificationsLoading();

      state = NotificationsSuccess();
    } catch (e) {
      state = NotificationsError(e.toString());
    }
  }


}


final notificationsProvider =
    StateNotifierProvider<NotificationsController, NotificationsState>((ref) {
  return NotificationsController(ref);
});



 abstract class NotificationsState {}

 class NotificationsInitial extends NotificationsState {}

 class NotificationsLoading extends NotificationsState {}

 class NotificationsSuccess extends NotificationsState {}

 class NotificationsError extends NotificationsState {
   final String message;

   NotificationsError(this.message);
 }
