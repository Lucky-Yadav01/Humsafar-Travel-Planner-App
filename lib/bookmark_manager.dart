import 'package:humsafar_p1/place_details/place_info.dart';

class BookmarkManager {
  static final BookmarkManager _instance = BookmarkManager._internal();

  factory BookmarkManager() => _instance;

  BookmarkManager._internal();

  final List<Place> _bookmarked = [];

  List<Place> get bookmarkedPlaces => List.unmodifiable(_bookmarked);

  bool isBookmarked(Place place) {
    return _bookmarked.any((p) => p.title == place.title && p.location == place.location);
  }

  void toggleBookmark(Place place) {
    final existingIndex = _bookmarked.indexWhere(
      (p) => p.title == place.title && p.location == place.location,
    );
    if (existingIndex != -1) {
      _bookmarked.removeAt(existingIndex);
    } else {
      _bookmarked.add(place);
    }
  }
}
