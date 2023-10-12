import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/shared/dotted_border.dart';

import 'upload_profile_photo_controller.dart';

class UploadProfilePhotoPage extends ConsumerStatefulWidget {
  const UploadProfilePhotoPage({super.key});

  @override
  ConsumerState createState() => _UploadProfilePhotoPageState();
}

class _UploadProfilePhotoPageState
    extends ConsumerState<UploadProfilePhotoPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  File? photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(
        title: 'Upload a profile picture',
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
                        'Make your profile stand out with a lovely photo of you. This will be public and appear to all users.',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  47.verticalSpace,
                  if (photo == null)
                    InkWell(
                        onTap: () async {
                          await _uploadPhoto(context);
                        },
                        child: const EmptyPhotoCard())
                  else
                    ImageWidget(
                      imageUrl: photo?.path ?? '',
                      imageType: ImageWidgetType.file,
                      width: 1.sw,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            ),
            ButtonWidget(
              title: 'Confirm',
              onTap: photo == null
                  ? null
                  : () {
                      context.goNamed(PageUrl.home);
                    },
            ),
            16.verticalSpace,
            TextView(
              text: 'Upload another photo',
              color: (photo == null)
                  ? Pallets.grey.withOpacity(0.2)
                  : Pallets.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              onTap: photo == null
                  ? null
                  : () async => await _uploadPhoto(context),
            ),
            45.verticalSpace,
          ],
        ),
      ),
    );
  }

  Future<void> _uploadPhoto(BuildContext context) async {
    photo = await ImageManager().showPhotoSourceDialog(context);

    setState(() {});
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
              const ImageWidget(imageUrl: Assets.svgsExport),
              8.verticalSpace,
              const TextView(
                text: 'Upload profile picture',
                color: Pallets.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: TextView(
                  text: 'Supported format: .jpeg,.png,.jpg less than 5MB',
                  color: Pallets.grey,
                  fontSize: 14,
                  align: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
