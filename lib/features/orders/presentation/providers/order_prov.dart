import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:simple_marketplace/features/orders/model/model_orders.dart' as model_order;
import 'package:simple_marketplace/features/orders/model/model_cart.dart' as model_cart;


final ordersProvider = StateNotifierProvider<OrdersNotifier, List<model_order.ModelOrders>?>((ref) {
  return OrdersNotifier();
});

class OrdersNotifier extends StateNotifier<List<model_order.ModelOrders>?> {
  OrdersNotifier(): super(<model_order.ModelOrders>[]);

  bool buyProducts = false;

  void buy(List<model_cart.ProductCheckOut> param) async {
      final List<model_order.Orders> listOrder = [];
      int totalPrice = 0;
      int totalItems = 0;

      final box = await Hive.openBox('orders');

      for (var i = 0; i < param.length; i++) {
        log('buy ${param[i].brand}');
        listOrder.add(model_order.Orders(
          brand: param[i].brand,
          category: param[i].category,
          description: param[i].description,
          discountPercentage: param[i].discountPercentage,
          id: param[i].id,
          images: param[i].images,
          price: param[i].price,
          quantity: param[i].quantity,
          rating: param[i].rating,
          stock: param[i].stock,
          thumbnail: param[i].thumbnail,
          title: param[i].title,
        ));
        totalItems += param[i].quantity!;
        totalPrice += (param[i].price! * param[i].quantity!);
      }

      box.add(model_order.ModelOrders(
        orders: listOrder,
        totalItems: totalItems,
        totalPrice: totalPrice
      ));

      buyProducts = true;

      final result = box.values.cast<model_order.ModelOrders>();
      state = result.toList();
    try {
    } catch (e) {
      log('buy Catch $e');
    }
  }

   void get() async {
    try {
      final box = await Hive.openBox('orders');
      final result = box.values.cast<model_order.ModelOrders>();
      state = result.toList();
      
    } catch (e) {
      log('orders get Catch $e');
    }
  }
  
}