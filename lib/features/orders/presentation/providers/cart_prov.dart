import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:simple_marketplace/features/orders/model/model_cart.dart' as model_cart;

final cartProvider = StateNotifierProvider.autoDispose<CartNotifier, List<model_cart.ProductCheckOut>?>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<model_cart.ProductCheckOut>?> {
  CartNotifier() : super(<model_cart.ProductCheckOut>[]);

  int totalPrice = 0;
  bool showChart = false;

  void initialAdd(model_cart.ProductCheckOut param) async {
    try {
      final box = await Hive.openBox('carts');

      box.add(model_cart.ProductCheckOut(
        brand: param.brand,
        category: param.category,
        description: param.description,
        discountPercentage: param.discountPercentage,
        id: param.id,
        images: param.images,
        price: param.price,
        quantity: 1,
        rating: param.rating,
        stock: param.stock,
        thumbnail: param.thumbnail,
        title: param.title,
      ));
      final result = box.values.cast<model_cart.ProductCheckOut>();
      state = result.toList();
    } catch (e) {
      log('cartProvider initialAdd Catch $e');
    }
  }

  void itemRemove(int index) async {
    final box = await Hive.openBox('carts');
    final result = box.values.cast<model_cart.ProductCheckOut>();
    box.deleteAt(index);
    if (mounted) {
      showChart = false;
      state = result.toList();
    }
  }

  void clear() async {
    final box = await Hive.openBox('carts');
    await box.clear();
    final result = box.values.cast<model_cart.ProductCheckOut>();
    state = result.toList();
  }

  void quantityAdd(int index) async {
    final box = await Hive.openBox('carts');
    final preData = box.values.cast<model_cart.ProductCheckOut>();
    int tempQuantity = preData.elementAt(index).quantity!;
    tempQuantity++;
    totalPrice = totalPrice + (preData.elementAt(index).price)!;
    box.putAt(
      index,
      model_cart.ProductCheckOut(
        brand: preData.elementAt(index).brand,
        category: preData.elementAt(index).category,
        description: preData.elementAt(index).description,
        discountPercentage: preData.elementAt(index).discountPercentage,
        id: preData.elementAt(index).id,
        images: preData.elementAt(index).images,
        price: preData.elementAt(index).price,
        quantity: tempQuantity,
        rating: preData.elementAt(index).rating,
        stock: preData.elementAt(index).stock,
        thumbnail: preData.elementAt(index).thumbnail,
        title: preData.elementAt(index).title,
      ),
    );
    final postData = box.values.cast<model_cart.ProductCheckOut>();
    state = postData.toList();
  }

  void quantitySubtract(int index) async {
    final box = await Hive.openBox('carts');
    final preData = box.values.cast<model_cart.ProductCheckOut>();
    int tempQuantity = preData.elementAt(index).quantity!;
    tempQuantity--;

    if (totalPrice != 0) {
      totalPrice = totalPrice - (preData.elementAt(index).price)!;
    }

    if (tempQuantity != 0) {
      box.putAt(
        index,
        model_cart.ProductCheckOut(
          brand: preData.elementAt(index).brand,
          category: preData.elementAt(index).category,
          description: preData.elementAt(index).description,
          discountPercentage: preData.elementAt(index).discountPercentage,
          id: preData.elementAt(index).id,
          images: preData.elementAt(index).images,
          price: preData.elementAt(index).price,
          quantity: tempQuantity,
          rating: preData.elementAt(index).rating,
          stock: preData.elementAt(index).stock,
          thumbnail: preData.elementAt(index).thumbnail,
          title: preData.elementAt(index).title,
        ),
      );

      final postData = box.values.cast<model_cart.ProductCheckOut>();
      state = postData.toList();
    } else {
      itemRemove(index);
    }
  }

  void get() async {
    final box = await Hive.openBox('carts');
    if (box.isNotEmpty) {
      final result = box.values.cast<model_cart.ProductCheckOut>();
      log('get $result');
      state = result.toList();
    }
  }
}
