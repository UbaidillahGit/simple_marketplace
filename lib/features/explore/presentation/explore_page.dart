import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_marketplace/utils/reusable_widgets/cart_snapping_sheet.dart';
import 'package:simple_marketplace/features/bookmark/presentation/providers/bookmark_prov.dart';
import 'package:simple_marketplace/features/explore/presentation/detail_page.dart';
import 'package:simple_marketplace/features/explore/presentation/providers/get_all_products.dart';
import 'package:simple_marketplace/features/orders/presentation/providers/cart_prov.dart';
import 'package:simple_marketplace/features/orders/presentation/providers/order_prov.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool showChart = true;

  @override
  void initState() {
    super.initState();
    _initAllProv();
  }

  ///__________ inital all providers, so the data can be automatilcally loaded
  void _initAllProv() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        ref.read(bookmarkProvider.notifier).get();

        ///_______ Load bookmarks if exist
        ref.read(cartProvider.notifier).get();

        ///_______ Load cart
      },
    );
  }

  void _showChart() async {
    setState(() {
      showChart = true;
      showMaterialModalBottomSheet(
        context: context,
        expand: false,
        bounce: false,
        enableDrag: false,
        builder: (context) => const CartSnappingSheet(),
      );
      showChart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(getAllProductsProvider);
    final bookmark = ref.watch(bookmarkProvider);
    final cart = ref.watch(cartProvider);
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    ///_________ Control the modal bottom sheet show and dismiss
    if (cart!.isEmpty && showChart == false && ref.watch(ordersProvider.notifier).buyProducts == false) {
      Future.delayed(
        const Duration(milliseconds: 200),
        () => Navigator.pop(context),
      );
    } else {
      ref.read(ordersProvider.notifier).buyProducts = false;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Explore', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: data.when(
        data: (data) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            children: data.products!.map(
              (e) {
                return SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailProductPage(e),
                      ));
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      elevation: 2,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: Image.network(e.thumbnail ?? '', height: 150, width: 200, fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  height: 20,
                                  child: Text(
                                    e.title ?? '-',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  child: Text(e.description ?? '-'),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 20),
                              Text(
                                '\$ ${e.price.toString()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const Spacer(),
                              if (bookmark!.contains(e)) ...[
                                IconButton(
                                  onPressed: () => ref.read(bookmarkProvider.notifier).remove(e),
                                  icon: const Icon(Icons.favorite, color: Colors.red),
                                )
                              ] else ...[
                                IconButton(
                                  onPressed: () => ref.read(bookmarkProvider.notifier).add(e),
                                  icon: const Icon(Icons.favorite_border),
                                )
                              ]
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
        },
        error: (error, stackTrace) {
          return const Center(
            child: Text('Error Occured'),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton:
          cart.isNotEmpty ? FloatingActionButton(onPressed: () => _showChart(), child: const Icon(Icons.shopping_cart)) : Container(),
    );
  }
}
