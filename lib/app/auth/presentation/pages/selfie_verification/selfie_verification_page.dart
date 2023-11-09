import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_profile_req_dto.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/face_plus_plus/detect_face_data.dart';
import 'package:triberly/core/face_plus_plus/face_plus_service.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/services/image_manipulation/cloudinary_manager.dart';
import 'package:triberly/core/shared/dotted_border.dart';

import 'selfie_verification_controller.dart';

class SelfieVerificationPage extends ConsumerStatefulWidget {
  const SelfieVerificationPage({
    super.key,
    required this.profilePhoto,
  });

  final String profilePhoto;

  @override
  ConsumerState createState() => _SelfieVerificationPageState();
}

class _SelfieVerificationPageState
    extends ConsumerState<SelfieVerificationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  ValueNotifier<File?> photo = ValueNotifier(null);

  DetectFaceData detectedFaceData = DetectFaceData();

  String? profilePhotoUrl;
  String? verificationPhotoUrl;

  @override
  Widget build(BuildContext context) {
    ref.listen(selfieVerificationProvider, (previous, next) {
      if (next is SelfieVerificationLoading) {
        CustomDialogs.showLoading(context);
      }

      if (next is SelfieVerificationError) {
        CustomDialogs.hideLoading(context);

        CustomDialogs.error(next.message);
      }

      if (next is SelfieVerificationSuccess) {
        CustomDialogs.hideLoading(context);
        context.goNamed(PageUrl.setupProfileIntroPage);
      }
    });
    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(
        title: 'Selfie Verification',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  24.verticalSpace,
                  const TextView(
                    text:
                        "Take a selfie to verify your profile. Don't worry, this is just between us. We won't display this photo.",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  ValueListenableBuilder(
                      valueListenable: photo,
                      builder: (context, photoValue, child) {
                        return Column(
                          children: [
                            24.verticalSpace,
                            PhotoQualityCheckTile(
                                detectedFaceData: detectedFaceData),
                            24.verticalSpace,
                            Builder(builder: (context) {
                              if (photoValue == null) {
                                return InkWell(
                                    onTap: () async {
                                      await _uploadPhoto(context);
                                    },
                                    child: const EmptyPhotoCard());
                              } else {
                                return ImageWidget(
                                  imageUrl: photo.value?.path ?? '',
                                  imageType: ImageWidgetType.file,
                                  width: 1.sw,
                                  height: 250,
                                  fit: BoxFit.contain,
                                );
                              }
                            }),
                          ],
                        );
                      }),
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: photo,
                builder: (context, value, child) {
                  return ButtonWidget(
                    title: 'Confirm',
                    onTap: value == null
                        ? null
                        : () async {
                            if (detectedFaceData.facePassed) {
                              await _uploadPhotosToCloud(context).then(
                                (value) => _updateProfile(),
                              );
                            } else {
                              CustomDialogs.error('Please add a valid photo');
                            }
                          },
                  );
                }),
            16.verticalSpace,
            TextView(
              text: 'Upload another photo',
              color: (photo.value == null)
                  ? Pallets.grey.withOpacity(0.2)
                  : Pallets.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              onTap: photo.value == null
                  ? null
                  : () async => await _uploadPhoto(context),
            ),
            45.verticalSpace,
          ],
        ),
      ),
    );
  }

  Future<void> _uploadPhotosToCloud(BuildContext context) async {
    CustomDialogs.showLoading(context);

    try {
      await Future.wait([
        CloudinaryManager.uploadFile(
            filePath: widget.profilePhoto, file: File(widget.profilePhoto)),
        CloudinaryManager.uploadFile(
          filePath: photo.value?.path ?? '',
          file: photo.value!,
        ),
      ]).then((value) {
        profilePhotoUrl = value[0];
        verificationPhotoUrl = value[1];
      });
    } catch (e) {
      logger.e(e);
    } finally {
      CustomDialogs.hideLoading(context);
    }
  }

  void _updateProfile() {
    final data = UpdateProfileReqDto(
      verificationImage: verificationPhotoUrl,
      profileImage: profilePhotoUrl,
    );

    ref.read(selfieVerificationProvider.notifier).caller(data);
  }

  Future<void> _detectFace(BuildContext context) async {
    CustomDialogs.showLoading(context);

    try {
      detectedFaceData = await FacePlusService.detectFaces(
        photo.value!,
      );
    } catch (e, sta) {
      logger.e(sta);
    } finally {
      setState(() {});
      CustomDialogs.hideLoading(context);
    }
  }

  Future<void> _uploadPhoto(BuildContext context) async {
    await ImageManager()
        .pickImageFromCamera(shouldCrop: true)
        .then((value) async {
      if (value != null) {
        photo.value = value;
        await _detectFace(context);
      }
    });
  }
}

class PhotoQualityCheckTile extends StatelessWidget {
  const PhotoQualityCheckTile({
    super.key,
    required this.detectedFaceData,
  });

  final DetectFaceData detectedFaceData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ImageWidget(
                imageUrl: detectedFaceData.isFaceUseful
                    ? Assets.svgsTickCircle
                    : Assets.svgsTick),
            16.horizontalSpace,
            Expanded(
              child: const TextView(
                text: 'Make sure there’s enough lighting',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        8.verticalSpace,
        Row(
          children: [
            ImageWidget(
                imageUrl: detectedFaceData.isBlurred
                    ? Assets.svgsTick
                    : Assets.svgsTickCircle),
            16.horizontalSpace,
            Expanded(
              child: const TextView(
                text: 'Clear pictures and not blurry',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        8.verticalSpace,
        Row(
          children: [
            ImageWidget(
                imageUrl: detectedFaceData.isFaceInFrame
                    ? Assets.svgsTickCircle
                    : Assets.svgsTick),
            16.horizontalSpace,
            Expanded(
              child: const TextView(
                text: 'Your face should be in the square',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class EmptyPhotoCard extends StatefulWidget {
  const EmptyPhotoCard({
    super.key,
  });

  @override
  State<EmptyPhotoCard> createState() => _EmptyPhotoCardState();
}

class _EmptyPhotoCardState extends State<EmptyPhotoCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          height: 250,
          width: 1.sw,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DashedRect(
            color: Pallets.primary,
            strokeWidth: 1.0,
            gap: 8.0,
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ImageWidget(imageUrl: Assets.svgsCamera),
              8.verticalSpace,
              const TextView(
                text: 'Tap to take selfie',
                color: Pallets.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        )
      ],
    );
  }
}
