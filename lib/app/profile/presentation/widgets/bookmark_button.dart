import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/core/_core.dart';

import '../../../../core/shared/image_widget.dart';
import '../../../../generated/assets.dart';
import '../../../community/presentation/controllers/bookmark_controller.dart';
import '../pages/profile_details/profile_details_page.dart';

class BookmarkButton extends ConsumerStatefulWidget {
  const BookmarkButton(this.userId, {super.key});

  final String userId;

  @override
  ConsumerState<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends ConsumerState<BookmarkButton> {
  AsyncValue<bool> isBooked = const AsyncData(false);

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        ref.read(bookMarkProvider.notifier).checkBookmark(widget.userId);
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

    if (ref.read(bookMarkProvider) is CheckBookmarkLoading ||
        ref.read(bookMarkProvider) is RemoveBookMarkLoading ||
        ref.read(bookMarkProvider) is AddBookMarkLoading) {
      return const ShadowCircleContainer(
        color: Pallets.white,
        child: CircularProgressIndicator(
          color: Pallets.primary,
        ),
      );
    }

    if (ref.read(bookMarkProvider.notifier).userBookmarked) {
      return InkWell(
        onTap: () {
          ref.read(bookMarkProvider.notifier).removeBookmark(widget.userId);
        },
        child: const ShadowCircleContainer(
          color: Pallets.primary,
          child: ImageWidget(
            imageUrl: Assets.svgsHeart,
            color: Pallets.white,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          // ref.refresh(isBookmarkedProvider(userId));
          // ref.read(isBookmarkedProvider(userId));
          ref.read(bookMarkProvider.notifier).addBookMark(widget.userId);
        },
        child: const ShadowCircleContainer(
          color: Pallets.white,
          child: ImageWidget(
            imageUrl: Assets.svgsHeart,
            color: Pallets.primary,
          ),
        ),
      );
    }
  }
}
