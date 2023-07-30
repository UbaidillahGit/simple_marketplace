import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_marketplace/features/explore/model/model_products.dart';

final getAllProductsProvider = FutureProvider<ModelProducts>((ref) async {
  try {
    final content = json.decode(await rootBundle.loadString('assets/file/products.json'));
    return ModelProducts.fromJson(content);
  } catch (e) {
    log('getAllProductsProvider Catch $e');
    rethrow;
  }
});