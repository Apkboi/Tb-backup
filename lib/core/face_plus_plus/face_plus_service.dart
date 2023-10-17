import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/face_plus_plus/detect_face_data.dart';
import 'package:triberly/core/face_plus_plus/face_compare_res.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';
import 'package:image/image.dart';
import 'package:triberly/core/services/_services.dart';

class FacePlusService {
  static int maxSizeInBytes = (2 * 1024 * 1024) - (200 * 1024);
  static String apiKey = UrlConfig.facePlusTestApiKey;
  static String apiSecret = UrlConfig.facePlusTestApiSecret;

  static Future<File> compressImage(File imageFile, int maxSizeInBytes) async {
    // Read the image file into Uint8List
    Uint8List imageBytes = await imageFile.readAsBytes();

    // Get the original image dimensions
    var originalInfo = decodeImage(Uint8List.fromList(imageBytes));

    int originalFileSize = imageBytes.length;
    logger.e(originalFileSize);
    logger.e(maxSizeInBytes);

    // Check if the image is already under the size limit
    if (originalFileSize <= maxSizeInBytes) {
      return imageFile; // No need to compress, return the original file.
    }

    // Calculate the compression quality factor
    double quality = (maxSizeInBytes / originalFileSize);

    // Compress the image with the calculated quality factor
    Uint8List compressedImage = await FlutterImageCompress.compressWithList(
      imageBytes,
      minWidth: originalInfo?.width ?? 480,
      minHeight: originalInfo?.height ?? 720,
      quality: quality.round(),
    );

    // Create a new compressed image file
    String compressedImagePath = imageFile.path.replaceFirst(
      RegExp(r'\.[a-zA-Z0-9]+$'),
      '_compressed.jpg', // You can choose the format you want
    );
    File compressedFile = File(compressedImagePath);

    // Write the compressed image data to the new file
    await compressedFile.writeAsBytes(compressedImage);

    Uint8List compressedFileBytes = await compressedFile.readAsBytes();

    // Get the original image dimensions

    int compressedFileSize = compressedFileBytes.length;

    logger.e(compressedFileSize);

    return compressedFile;
  }

  static Future<FaceCompareRes> compareFaces(String path1, String path2) async {
    ///Get Ensure images are compressed to Faceplusplus required 2mb
    await Future.wait([
      compressImage(File(path1), maxSizeInBytes),
      compressImage(File(path2), maxSizeInBytes)
    ]).then((value) {
      path1 = value[0].path;
      path2 = value[1].path;
    });

    Dio dio = Dio(
      BaseOptions(
        headers: {'Content-Type': Headers.multipartFormDataContentType},
      ),
    );

    String filePath1 = path1;
    String filePath2 = path2;

    FormData formData = FormData.fromMap({
      'api_key': apiKey,
      'api_secret': apiSecret,
      'image_file1':
          await MultipartFile.fromFile(filePath1, filename: "image_1"),
      'image_file2':
          await MultipartFile.fromFile(filePath2, filename: "image_2"),
    });

    try {
      Response response = await dio.post(
        'https://api-us.faceplusplus.com/facepp/v3/compare',
        data: formData,
      );

      if (response.statusCode == 200) {
        logger.e(response.data);
        return FaceCompareRes.fromJson(response.data);
        // print(response.data);
      } else {
        throw response.data['error_message'] as String;
      }
    } catch (e) {
      // Handle any exceptions or errors
      if (e is DioError && e.response != null) {
        // Handle DioError with response

        logger.e(e.toString());
        logger.e(e.response);
        throw e.response!.data['error_message'] as String;
      } else {
        // Handle other exceptions
        throw 'An error occurred: $e';
      }
    }
  }

  static Future<DetectFaceData> detectFaces(File imageFile) async {
    DetectFaceData detectFaceData = DetectFaceData();
    Dio dio = Dio();
    String url = 'https://api-us.faceplusplus.com/facepp/v3/detect';

    final another = await compressImage(imageFile, maxSizeInBytes);
    // final another = await compressImage(imageFile, maxSizeInBytes);
    FormData formData = FormData.fromMap({
      'api_key': apiKey,
      'api_secret': apiSecret,
      'image_file':
          await MultipartFile.fromFile(another.path, filename: "image_1"),
      'return_attributes': 'blur,facequality',
    });

    try {
      Response response = await dio.post(url, data: formData);

      final faceData = response.data['faces'] as List;

      if (faceData.isNotEmpty) {
        final blurValue =
            faceData.first['attributes']['blur']['blurness']['value'];
        final blurThreshold =
            faceData.first['attributes']['blur']['blurness']['threshold'];

        final faceThreshold =
            faceData.first['attributes']['facequality']['threshold'];
        final faceValue = faceData.first['attributes']['facequality']['value'];

        final isTooBlurred = blurValue < blurThreshold;
        final isFaceBad = faceValue < faceThreshold;

        detectFaceData.isFaceInFrame = true;
        detectFaceData.isBlurred = isTooBlurred;
        detectFaceData.isFaceUseful = !isFaceBad;

        logger.i("Blur status $isTooBlurred");
        logger.i("Face Status $isFaceBad");
      }

      logger.e(detectFaceData);
      return detectFaceData;
    } catch (e) {
      logger.e(e.toString());
      if (e is DioError && e.response != null) {
        // Handle DioError with response

        logger.e(e.toString());
        logger.e(e.response);
        throw e.response!.data['error_message'] as String;
      }

      // Handle any exceptions
      throw 'An error occurred: $e';
    }
  }
}
