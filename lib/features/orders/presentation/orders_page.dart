import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_marketplace/features/orders/presentation/providers/order_prov.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(
      const Duration(milliseconds: 500),
      () => ref.read(ordersProvider.notifier).get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersProvider);
    log('widget orders $orders');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: orders!.isNotEmpty
          ? ListView.separated(
            padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      orders[index].orders?[0].thumbnail ?? '',
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${orders[index].orders?[0].title} + ${(orders[index].totalItems ?? 0 - 1)} others'),
                      Text('\$ ${orders[index].totalPrice} '),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(color: Colors.grey),
              itemCount: orders.length)
          : const Center(child: Text('No Orders')),
    );
  }
}
