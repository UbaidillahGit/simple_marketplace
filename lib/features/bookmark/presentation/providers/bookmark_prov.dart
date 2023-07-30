import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:simple_marketplace/features/explore/model/model_products.dart' as model_products;

final bookmarkProvider = StateNotifierProvider.autoDispose<BookmarkNotifier, List<model_products.Products>?>((ref) {
  return BookmarkNotifier();
});

class BookmarkNotifier extends StateNotifier<List<model_products.Products>?> {
  BookmarkNotifier() : super(<model_products.Products>[]);

  void add(model_products.Products param) async {
    try {
      final box = await Hive.openBox('bookmarks');
      final result = box.values.cast<model_products.Products>();
      if (!result.contains(param)) {
        box.add(param);
        state = result.toList();
      }
    } catch (e) {
      log('addFavoriteProvider Catch $e');
    }
  }

  void remove(model_products.Products param) async {
    final box = await Hive.openBox('bookmarks');
    final result = box.values.cast<model_products.Products>();
    box.delete(param.key);
    state = result.toList();
  }

  void get() async {
    final box = await Hive.openBox('bookmarks');
    final result = box.values.cast<model_products.Products>();
    state = result.toList();
  }

  void clear() async {
    final box = await Hive.openBox('bookmarks');
    final result = box.values.cast<model_products.Products>();
    box.clear();
    state = result.toList();
  }
}
