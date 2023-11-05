import 'package:triberly/app/community/dormain/models/dtos/get_connections_res_dto.dart';
import 'package:triberly/app/community/dormain/models/dtos/save_connection_res_dto.dart';
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

  Future<SaveConnectionResDto?> saveConnections(String userId,String? message) async {
    try {
      final response = await _networkService(
        UrlConfig.saveConnection,
        RequestMethod.post,
        data: {
          'user_id': userId,
          "message": message
        },
      );

      return SaveConnectionResDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
