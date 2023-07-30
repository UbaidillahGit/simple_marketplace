import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_marketplace/utils/reusable_widgets/cart_snapping_sheet.dart';
import 'package:simple_marketplace/features/bookmark/presentation/providers/bookmark_prov.dart';
import 'package:simple_marketplace/features/explore/model/model_products.dart' as model_products;
import 'package:simple_marketplace/features/orders/model/model_cart.dart' as model_cart;
import 'package:simple_marketplace/features/orders/presentation/providers/cart_prov.dart';

class DetailProductPage extends ConsumerStatefulWidget {
  const DetailProductPage(this.detail, {super.key});
  final model_products.Products detail;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends ConsumerState<DetailProductPage> {

  late model_cart.ProductCheckOut singleChart;
  bool showChart = true;
  RouteSettings? _routeSettings;

  @override
  void initState() {
    super.initState();

    ref.read(cartProvider);
    _assignModel();
  }

  void _showCart() async {
    Future.delayed(
        const Duration(milliseconds: 200),
        () {
          showMaterialModalBottomSheet(
            context: context,
            expand: false,
            bounce: false,
            enableDrag: false,
            useRootNavigator: true,
            settings: _routeSettings,
            builder: (context) => const CartSnappingSheet(),
          ).whenComplete(() => {});
        },
      );
    setState(() => showChart = false);
  }

  void _fnAddToCart() async {
    ref.read(cartProvider.notifier).initialAdd(model_cart.ProductCheckOut(
          brand: widget.detail.brand,
          category: widget.detail.category,
          description: widget.detail.description,
          discountPercentage: widget.detail.discountPercentage,
          id: widget.detail.id,
          images: widget.detail.images,
          price: widget.detail.price,
          rating: widget.detail.rating,
          stock: widget.detail.stock,
          thumbnail: widget.detail.thumbnail,
          title: widget.detail.title,
        ));
  }

  void _assignModel() {
    singleChart = model_cart.ProductCheckOut(
      brand: widget.detail.brand,
      category: widget.detail.category,
      description: widget.detail.description,
      discountPercentage: widget.detail.discountPercentage,
      id: widget.detail.id,
      images: widget.detail.images,
      price: widget.detail.price,
      rating: widget.detail.rating,
      stock: widget.detail.stock,
      thumbnail: widget.detail.thumbnail,
      title: widget.detail.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookmark = ref.watch(bookmarkProvider);
    final cart = ref.watch(cartProvider);

    ///_________ Control the modal bottom sheet show and dismiss
    if (cart!.contains(singleChart) && showChart) {
      _showCart();
    } else if(cart.isEmpty && !showChart) {
      Future.delayed(
        const Duration(milliseconds: 200),
        () => Navigator.pop(context),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Image.network(
                    widget.detail.thumbnail ?? '',
                    width: double.infinity,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 35,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_circle_left,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
            Column(
                children: [
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.detail.title.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('\$ ${widget.detail.price.toString()}'),
                                ],
                              ),
                              const Spacer(),
                              if (bookmark!.contains(widget.detail)) ...[
                                IconButton(
                                  onPressed: () => ref.read(bookmarkProvider.notifier).remove(widget.detail),
                                  icon: const Icon(Icons.favorite, color: Colors.red),
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                )
                              ] else ...[
                                IconButton(
                                  onPressed: () => ref.read(bookmarkProvider.notifier).add(widget.detail),
                                  icon: const Icon(Icons.favorite_border),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                )
                              ]
                            ],
                          ),
                          Text(widget.detail.description.toString())
                          // SizedBox(
                          //   height: 200,
                          //   child: ListView(
                          //     children: [
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !cart.contains(singleChart)
          ? ElevatedButton(
              onPressed: () => _fnAddToCart(),
              child: const Text('Add to chart '),
            )
          : Container(),
    );
  }
}