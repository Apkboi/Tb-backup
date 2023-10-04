import 'package:flutter_riverpod/flutter_riverpod.dart';


class ChatController extends StateNotifier<ChatState>{

  ChatController(this.ref) : super(ChatInitial());
  final StateNotifierProviderRef ref;

  Future<void> caller() async {
    try {
      state = ChatLoading();

      state = ChatSuccess();
    } catch (e) {
      state = ChatError(e.toString());
    }
  }


}


final chatProvider =
    StateNotifierProvider<ChatController, ChatState>((ref) {
  return ChatController(ref);
});



 abstract class ChatState {}

 class ChatInitial extends ChatState {}

 class ChatLoading extends ChatState {}

 class ChatSuccess extends ChatState {}

 class ChatError extends ChatState {
   final String message;

   ChatError(this.message);
 }
