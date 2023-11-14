import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/community/dormain/services/connection_imp_service.dart';

import '../../../../core/services/di/di.dart';

abstract class BookmarkState {}

class BookMarkController extends StateNotifier<BookmarkState> {
  BookMarkController(this._connectionService) : super(BookmarkInitial());
  final ConnectionImpService _connectionService;
  bool userBookmarked = false;
  bool userInFav = false;

  Future<void> addBookMark(String userId) async {
    state = AddBookMarkLoading();
    // await Future.delayed(const Duration(milliseconds: 500));
    try {
      final response = await _connectionService.addBookmark(userId);

      state = AddBookmarkSuccess();
      checkBookmark(userId);

    } catch (e) {
      state = AddBookmarkFailure(e.toString());
      logger.e(userId);
      logger.e(e.toString());
    }
    // state = AddBookmarkFailure("message");

    logger.i('message');
  }

  Future<void> addFavorite(String userId) async {
    state = AddFavoriteLoading();
    try {
      final response = await _connectionService.addFavorite(userId);

      state = AddFavoriteSuccess();
      checkFavorite(userId);
    } catch (e) {
      state = AddFavoriteFailure(e.toString());
    }
  }

  Future<void> removeBookmark(String userId) async {
    state = RemoveBookMarkLoading();
    try {
      final response = await _connectionService.removeBookmark(userId);

      state = RemoveBookmarkSuccess();
      checkBookmark(userId);
    } catch (e) {
      state = RemoveBookmarkFailure(e.toString());
    }
  }

  Future<void> removeFavorite(String userId) async {
    state = RemoveFavoriteLoading();
    try {
      final response = await _connectionService.removeFavorite(userId);

      state = RemoveVFavoriteSuccess();
      checkFavorite(userId);

    } catch (e) {
      state = RemoveFavoriteFailure(e.toString());
    }
  }

  Future<void> checkBookmark(String userId) async {
    state = CheckBookmarkLoading();
    try {
      final response = await _connectionService.checkBookmark(userId);
      userBookmarked = response?.isBookmarked ?? false;

      state = CheckBookmarkSuccess();

    } catch (e) {
      state = CheckBookmarkFailure(e.toString());
    }
  }

  Future<void> checkFavorite(String userId) async {
    state = CheckFavouriteLoading();

    try {
      final response = await _connectionService.checkFavorites(userId);

      userInFav = response.isFavourite ?? false;

      state = CheckFavouriteSuccess();
    } catch (e) {
      state = CheckFavouriteFailure(e.toString());
    }
  }
}

final bookMarkProvider =
    StateNotifierProvider<BookMarkController, BookmarkState>(
        (ref) => BookMarkController(sl.get()));

class BookmarkInitial extends BookmarkState {}

class AddBookMarkLoading extends BookmarkState {}

class AddBookmarkSuccess extends BookmarkState {}

class AddBookmarkFailure extends BookmarkState {
  final String message;

  AddBookmarkFailure(this.message);
}

class RemoveBookMarkLoading extends BookmarkState {}

class RemoveBookmarkSuccess extends BookmarkState {}

class RemoveBookmarkFailure extends BookmarkState {
  final String message;

  RemoveBookmarkFailure(this.message);
}

class AddFavoriteLoading extends BookmarkState {}

class AddFavoriteSuccess extends BookmarkState {}

class AddFavoriteFailure extends BookmarkState {
  final String message;

  AddFavoriteFailure(this.message);
}

class CheckBookmarkLoading extends BookmarkState {}

class CheckBookmarkSuccess extends BookmarkState {}

class CheckBookmarkFailure extends BookmarkState {
  final String message;

  CheckBookmarkFailure(this.message);
}

class CheckFavouriteLoading extends BookmarkState {}

class CheckFavouriteSuccess extends BookmarkState {}

class CheckFavouriteFailure extends BookmarkState {
  final String message;

  CheckFavouriteFailure(this.message);
}

class RemoveFavoriteLoading extends BookmarkState {}

class RemoveVFavoriteSuccess extends BookmarkState {}

class RemoveFavoriteFailure extends BookmarkState {
  final String message;

  RemoveFavoriteFailure(this.message);
}

final isBookmarkedProvider =
    FutureProvider.family<bool, String>((ref, id) async {
  final ConnectionImpService _connectionService = sl.get();
  try {
    final response = await _connectionService.checkBookmark(id);
    return response?.isBookmarked ?? false;
    // state = AddBookmarkSuccess();
  } catch (e) {
    return false;
    // state = AddBookmarkFailure(e.toString());
  }
});
