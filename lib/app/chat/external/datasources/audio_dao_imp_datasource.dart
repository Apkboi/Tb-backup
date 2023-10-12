import 'package:dio/dio.dart';
import 'package:triberly/core/_core.dart';

import '../../data/datasources/audio_dao_datasource.dart';

import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class AudioDaoImpDatasource implements AudioDaoDatasource {
  static const String _hiveBoxName = 'audio_cache';

  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }

  // Initialize Hive and open the box
  Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    await Hive.openBox<String>(_hiveBoxName);
  }

  // Download and save audio if not already cached, returns the local file path
  Future<String> getAudioFilePath(String url) async {
    final audioBox = await Hive.openBox<String>(_hiveBoxName);

    String? cachedPath = audioBox.get(url);

    if (cachedPath == null) {
      // URL not found in Hive, download and save the audio
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final fileName = url.split('/').last;
        final file = File(
            '${(await getApplicationDocumentsDirectory()).path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        final localPath = file.path;

        // Save the local path in Hive
        audioBox.put(url, localPath);

        return localPath;
      } else {
        throw Exception('Failed to download audio');
      }
    }

    return cachedPath;
  }

  void close() {
    Hive.close();
  }
}
