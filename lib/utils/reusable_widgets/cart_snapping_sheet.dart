
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_marketplace/features/orders/presentation/providers/cart_prov.dart';
import 'package:simple_marketplace/features/orders/presentation/providers/order_prov.dart';

class CartSnappingSheet extends ConsumerWidget {
  const CartSnappingSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    int totalPrice = 0;
    for (var i = 0; i < cart!.length; i++) {
      totalPrice += (cart[i].quantity! * cart[i].price!);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: double.infinity,
            minHeight: 0,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const Divider(color: Colors.grey,);
            },
            itemBuilder: (context, index) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    cart[index].thumbnail ?? '',
                    // width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${cart[index].title} '),
                    Text('\$ ${cart[index].price} '),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => ref.read(cartProvider.notifier).itemRemove(index,),
                      icon: const Icon(Icons.delete, color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () => ref.read(cartProvider.notifier).quantitySubtract(index),
                      icon: const Icon(Icons.remove_circle, color: Colors.black),
                    ),
                    Text('${cart[index].quantity}'),
                    IconButton(
                      onPressed: () => ref.read(cartProvider.notifier).quantityAdd(index),
                      icon: const Icon(Icons.add_circle, color: Colors.black),
                    )
                  ],
                ),
              );
            },
            itemCount: cart.length,
          )
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          // height: 100,
          color: Colors.black87,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Price', style: TextStyle(color: Colors.white)),
                  Text(
                    '\$ $totalPrice',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(ordersProvider.notifier).buy(cart);
                  ref.read(cartProvider.notifier).clear();
                  Navigator.pop(context);
                },
                child: const Text('Buy'),
              )
            ],
          ),
        )
      ],
    );
  }
}