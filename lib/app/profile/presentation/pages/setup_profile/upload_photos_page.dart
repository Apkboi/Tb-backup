import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/domain/models/dtos/update_other_photos_req_dto.dart';
import 'package:triberly/app/auth/presentation/widgets/onboarding/intro_dialog.dart';
import 'package:triberly/app/profile/presentation/widgets/gradient_slider.dart';
import 'package:triberly/app/profile/presentation/widgets/upload_photo_widget.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/_services.dart';
import 'package:triberly/core/services/image_manipulation/cloudinary_manager.dart';
import 'package:triberly/core/utils/color_utils.dart';

import 'setup_profile_controller.dart';

const String blackMale =
    "https://firebasestorage.googleapis.com/v0/b/triberly-app.appspot.com/o/app_images%2FBlack%20male%20image%203.png?alt=media&token=da8a27ac-9a38-43ed-897f-8d953768d2ce&_gl=1*ac074h*_ga*MTcyOTUxNDYxLjE2OTA4NjU0MzM.*_ga_CW55HF8NVT*MTY5NjYzNjkzNS4zMC4xLjE2OTY2MzY5NDYuNDkuMC4w";

class UploadPhotosPage extends ConsumerStatefulWidget {
  const UploadPhotosPage({super.key});

  @override
  ConsumerState createState() => _UploadPhotosPageState();
}

class _UploadPhotosPageState extends ConsumerState<UploadPhotosPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    dialogKey.currentState?.dispose();
    super.dispose();
  }

  List<String?> imagesList = [
    null,
    null,
    null,
    null,
  ];

  LinearGradient gradient = LinearGradient(colors: <Color>[
    UtilColor.fromHex('#EF0096').withOpacity(0.5),
    UtilColor.fromHex('#EF0096'),
  ]);

  double sliderValue = 1;

  @override
  Widget build(BuildContext context) {
    ref.listen(setupProfileProvider, (previous, next) {
      if (next is UploadOtherPhotosLoading) {
        CustomDialogs.showLoading(context);
      }

      if (next is UploadOtherPhotosError) {
        CustomDialogs.hideLoading(context);

        CustomDialogs.error(next.message);
      }

      if (next is UploadOtherPhotosSuccess) {
        CustomDialogs.hideLoading(context);
        CustomDialogs.showFlushBar(
          context,
          'Photos uploaded successfully',
        );


        // Update Login Preferences and proceed
        ref.read(isFirsTImeProvider.notifier).state = true;
        // SessionManager.instance.isLoggedIn = true;
        context.pushNamed(PageUrl.setupProfilePage);
      }
    });
    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(title: 'Build your profile'),
      body: Column(
        children: [
          SliderTheme(
              data: SliderThemeData(
                trackHeight: 10,
                inactiveTrackColor: Pallets.primaryLight,
                thumbShape: SliderComponentShape.noThumb,
                trackShape: GradientRectSliderTrackShape(
                  gradient: gradient,
                  sliderValue: (sliderValue),
                  darkenInactive: true,
                ),
              ),
              child: Slider(
                min: 0,
                max: 10,
                value: sliderValue,
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              )),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  21.verticalSpace,
                  const TextView(
                    text: 'Upload photos',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  8.verticalSpace,
                  const TextView(
                    text:
                    'Add some more really cool photos of you living your best life, so others get a vibe of the amazing you.',
                    fontSize: 14,
                    color: Pallets.grey,
                  ),
                  32.verticalSpace,
                  Column(
                    children: [
                      const TextView(
                        text: 'Tap to add images',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Pallets.grey,
                      ),
                      16.verticalSpace,
                      GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        itemCount: imagesList.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.0.dg,
                          mainAxisSpacing: 20.0.dg,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final singleItem = imagesList[index];
                          return UploadPhotosWidget(
                            imageUrl: singleItem,
                            delete: () {
                              imagesList[index] = null;
                              setState(() {});
                            },
                            onTap: () async {
                              final imageManger = ImageManager();

                              final imageFile = await imageManger
                                  .showPhotoSourceDialog(context);

                              imagesList[index] = imageFile?.path;

                              setState(() {});
                            },
                          );
                        },
                      ),
                      57.verticalSpace,
                      ButtonWidget(
                        title: 'Next',
                        onTap: (imagesList.contains(null))
                            ? null
                            : () async {
                          ///UPload Photos
                          ///

                          CustomDialogs.showLoading(context);

                          try {
                            await Future.wait(
                              List.generate(
                                imagesList.length,
                                    (index) =>
                                    CloudinaryManager.uploadFile(
                                      filePath: imagesList[index]!,
                                      file: File(
                                        imagesList[index]!,
                                      ),
                                    ),
                              ),
                            ).then(
                                  (value) {
                                CustomDialogs.hideLoading(context);

                                ref
                                    .read(setupProfileProvider.notifier)
                                    .uploadOtherPhotos(
                                  UpdateOtherPhotosReqDto(
                                    images: value,
                                  ),
                                );
                              },
                            );
                          } catch (e) {
                            CustomDialogs.hideLoading(context);

                            CustomDialogs.error(e.toString());
                            logger.e('message');
                          }


                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
