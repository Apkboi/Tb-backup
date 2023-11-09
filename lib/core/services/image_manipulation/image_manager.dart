import 'dart:io';
import 'dart:math';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../_core.dart';

class ImageManager {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromCamera(
      {bool? shouldCompress, bool? shouldCrop}) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      if (shouldCrop ?? false) {
        final imageFile2 = await _cropImage(imageFile);
        imageFile = File(imageFile2!.path);
      }
      if (shouldCompress ?? false) {
        imageFile = await _compressImage(imageFile);
      }
      return imageFile;
    }

    return null;
  }

  Future<File?> pickImageFromGallery(
      {bool? shouldCompress, bool? shouldCrop}) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      if (shouldCrop ?? false) {
        final imageFile2 = await _cropImage(imageFile);

        imageFile = File(imageFile2!.path);
      }
      if (shouldCompress ?? false) {
        imageFile = await _compressImage(imageFile);
      }
      return imageFile;
    }
    return null;
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    return await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Triberly',
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Triberly',
        ),
      ],
    );
  }

  Future<File> _compressImage(File imageFile) async {
    final tempDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final targetPath =
        "${tempDir?.absolute.path}/img_${Random().nextInt(10000)}.jpg";

    final result = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      targetPath,
      quality: 88,
    );

    if (result != null) {
      return File(result.path);
    } else {
      throw Exception("Failed to compress image");
    }
  }

  Future<File?> showPhotoSourceDialog(BuildContext context,
      {bool? shouldCompress, bool? shouldCrop}) {
    return showModalBottomSheet<File?>(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 45.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextView(
                text: 'Upload Image',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              34.verticalSpace,
              ButtonWidget(
                title: 'Open Camera',
                onTap: () async {
                  try {
                    await pickImageFromCamera(shouldCrop: shouldCrop)
                        .then((value) => Navigator.pop(context, value));
                  } catch (e) {
                    logger.e(e.toString());
                  }
                },
              ),
              20.verticalSpace,
              ButtonWidget(
                title: 'Upload from gallery',
                isInverted: true,
                onTap: () async {
                  try {
                    await pickImageFromGallery(shouldCrop: shouldCrop)
                        .then((value) => Navigator.pop(context, value));
                  } catch (e) {
                    logger.e(e.toString());
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }


  Future<File?> showDocumentSourceDialog(BuildContext context,
      {bool? shouldCompress, bool? shouldCrop}) {
    return showModalBottomSheet<File?>(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 45.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextView(
                text: 'Upload Image',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              34.verticalSpace,
              ButtonWidget(
                title: 'Open Camera',
                onTap: () async {
                  try {
                    await pickImageFromCamera(shouldCrop: shouldCrop)
                        .then((value) => Navigator.pop(context, value));
                  } catch (e) {
                    logger.e(e.toString());
                  }
                },
              ),
              20.verticalSpace,
              ButtonWidget(
                title: 'Upload from gallery',
                isInverted: true,
                onTap: () async {
                  try {
                    await pickImageFromGallery(shouldCrop: shouldCrop)
                        .then((value) => Navigator.pop(context, value));
                  } catch (e) {
                    logger.e(e.toString());
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
