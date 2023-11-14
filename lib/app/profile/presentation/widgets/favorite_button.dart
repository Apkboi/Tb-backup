import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';

import '../../../../core/shared/image_widget.dart';
import '../../../../generated/assets.dart';
import '../../../community/presentation/controllers/bookmark_controller.dart';
import '../pages/profile_details/profile_details_page.dart';

class FavoriteButton extends ConsumerStatefulWidget {
  const FavoriteButton(this.userId, {super.key});

  final String userId;

  @override
  ConsumerState<FavoriteButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends ConsumerState<FavoriteButton> {
  AsyncValue<bool> isBooked = const AsyncData(false);

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
          () {
        ref.read(bookMarkProvider.notifier).checkFavorite(widget.userId);
      },
    );
    super.initState();
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    // // var bookmarkProvider = ref.watch(bookMarkProvider);
    // var isBookmark = ref.read(isBookmarkedProvider(userId));
    ref.listen(bookMarkProvider, (previous, next) {
      setState(() {});

      if (next is AddBookmarkFailure) {
        CustomDialogs.hideLoading(context);
        CustomDialogs.error(next.message);
      }
      if (next is AddBookmarkSuccess) {
        ref.read(isBookmarkedProvider(widget.userId));

        setState(() {});
      }

      // if (next is RemoveBookMarkLoading) {
      //   CustomDialogs.showLoading(context);
      // }
      if (next is RemoveBookmarkFailure) {
        CustomDialogs.error(next.message);
      }
    });

    if (ref.read(bookMarkProvider) is CheckFavouriteLoading ||
        ref.read(bookMarkProvider) is RemoveFavoriteLoading ||
        ref.read(bookMarkProvider) is AddFavoriteLoading) {
      return const ShadowCircleContainer(
        color: Pallets.white,
        child: CircularProgressIndicator(
          color: Pallets.primary,
        ),
      );
    }

    if (ref.read(bookMarkProvider.notifier).userInFav) {
      return InkWell(
        onTap: () {
          ref.read(bookMarkProvider.notifier).removeFavorite(widget.userId);
        },
        child: const ShadowCircleContainer(
          color: Pallets.primary,
          child: ImageWidget(
            imageUrl: Assets.svgsBookmark,
            color: Pallets.white,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          // ref.refresh(isBookmarkedProvider(userId));
          // ref.read(isBookmarkedProvider(userId));
          ref.read(bookMarkProvider.notifier).addFavorite(widget.userId);
        },
        child: const ShadowCircleContainer(
          color: Pallets.white,
          child: ImageWidget(
            imageUrl: Assets.svgsBookmark,
            color: Pallets.primary,
          ),
        ),
      );
    }
  }
}