import 'package:triberly/app/chat/domain/models/dtos/get_chats_res_dto.dart';
import 'package:triberly/app/chat/domain/models/dtos/initiate_chat_res_dto.dart';
import 'package:triberly/app/profile/domain/models/dtos/search_connections_req_dto.dart';
import 'package:triberly/app/profile/domain/models/dtos/search_connections_res_dto.dart';
import 'package:triberly/core/services/network/network_service.dart';
import 'package:triberly/core/services/network/url_config.dart';

import 'chat_service.dart';

class ChatImpService implements ChatService {
  final NetworkService _networkService;
  ChatImpService(this._networkService);
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }

  Future<GetChatsResDto?> getChats() async {
    try {
      final response = await _networkService(
        UrlConfig.getChats,
        RequestMethod.get,
        // queryParams: data.toJson(),
      );

      return GetChatsResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<InitiateChatResDto?> initiateChat(String userId) async {
    try {
      final response = await _networkService(
        UrlConfig.initiateChat,
        RequestMethod.post,
        data: {'recipient_id': userId},
      );

      return InitiateChatResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
