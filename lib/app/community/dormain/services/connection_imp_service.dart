import 'package:triberly/app/community/dormain/models/dtos/add_bookmark_response.dart';
import 'package:triberly/app/community/dormain/models/dtos/add_favorites_response.dart';
import 'package:triberly/app/community/dormain/models/dtos/check_bookmark_response.dart';
import 'package:triberly/app/community/dormain/models/dtos/get_connections_res_dto.dart';
import 'package:triberly/app/community/dormain/models/dtos/remove_bookmar_response.dart';
import 'package:triberly/app/community/dormain/models/dtos/save_connection_res_dto.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/network/network_service.dart';
import 'package:triberly/core/services/network/url_config.dart';

import 'connection_service.dart';

class ConnectionImpService implements ConnectionService {
  final NetworkService _networkService;

  ConnectionImpService(this._networkService);

  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }

  Future<GetConnectionsResDto?> getConnections() async {
    try {
      final response = await _networkService(
        UrlConfig.getConnections,
        RequestMethod.get,
        // queryParams: data.toJson(),
      );

      return GetConnectionsResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<SaveConnectionResDto?> saveConnections(
      String userId, String? message) async {
    try {
      final response = await _networkService(
        UrlConfig.saveConnection,
        RequestMethod.post,
        data: {'user_id': userId, "message": message},
      );

      return SaveConnectionResDto.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<AddBookmarkResponse?> addBookmark(String userId) async {
    try {
      final response = await _networkService(
          UrlConfig.addBookmark, RequestMethod.post,
          data: {"bookmark_user_id": userId}
          // queryParams: data.toJson(),
          );

      return AddBookmarkResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<RemoveBookmarkResponse?> removeBookmark(
    String userId,
  ) async {
    try {
      final response = await _networkService(
        UrlConfig.removeBookmark,
        RequestMethod.post,
        data: {"bookmark_user_id": userId},
      );

      return RemoveBookmarkResponse.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<AddFavoriteResponse?> addFavorite(String userId) async {
    try {
      final response = await _networkService(
          UrlConfig.addFavorite, RequestMethod.post,
          data: {"liked_user_id": userId}

          // queryParams: data.toJson(),
          );

      return AddFavoriteResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<RemoveBookmarkResponse?> removeFavorite(
    String userId,
  ) async {
    try {
      final response = await _networkService(
          UrlConfig.removeFavorite, RequestMethod.post,
          data: {"liked_user_id": userId});

      return RemoveBookmarkResponse.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<CheckBookmarkResponse?> checkBookmark(
    String userId,
  ) async {
    try {
      final response = await _networkService(
          UrlConfig.checkBookmark, RequestMethod.get,
          queryParams: {"bookmark_user_id": userId});

      return CheckBookmarkResponse.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<CheckBookmarkResponse> checkFavorites(
    String userId,
  ) async {
    try {
      final response = await _networkService(
          UrlConfig.checkFavorite, RequestMethod.get,
          queryParams: {"liked_user_id": userId});

      return CheckBookmarkResponse.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
