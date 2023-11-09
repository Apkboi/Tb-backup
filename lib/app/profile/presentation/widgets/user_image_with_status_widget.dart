import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triberly/core/constants/pallets.dart';
import 'package:triberly/core/shared/image_widget.dart';

class UserImageWithStatusWidget extends StatelessWidget {
  const UserImageWithStatusWidget(
      {Key? key, this.imageUrl,  this.status= 50})
      : super(key: key);
  final String? imageUrl;
  final int? status;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        ImageWidget(
          imageUrl:imageUrl??'',
          size: 100.w,
          fit: BoxFit.cover,
          color: Colors.red,
          imageType: imageUrl!=null?ImageWidgetType.network: ImageWidgetType.asset,
          shape: BoxShape.circle,
        ),
        SizedBox(
          height: 106.w,
          width: 106.w,
          child:  CircularProgressIndicator(
            value: status!*0.01,
          ),
        ),
        Positioned(
          bottom: -25,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Pallets.primary,
                  borderRadius: BorderRadius.circular(20.r)),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "$status% Complete",
                  textAlign: TextAlign.center,
                  style:const TextStyle(
                      fontSize: 10,
                      color: Pallets.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
