
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_marketplace/features/bookmark/presentation/providers/bookmark_prov.dart';
import 'package:simple_marketplace/features/explore/presentation/detail_page.dart';

class BookmarkPage extends ConsumerStatefulWidget {
  const BookmarkPage({super.key});

  @override
  ConsumerState<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends ConsumerState<BookmarkPage> {
  @override
  void initState() {
    super.initState();
    ref.read(bookmarkProvider.notifier).get();
  }

  @override
  Widget build(BuildContext context) {
    final bookmark = ref.watch(bookmarkProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: bookmark!.isNotEmpty
          ? ListView(
              children: bookmark
                  .map((e) => InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailProductPage(e))),
                    child: Card(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              child: Image.network(
                                e.thumbnail ?? '',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(e.title ?? '-'),
                                      Text(
                                        '\$ ${e.price.toString()}',
                                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  if (bookmark.contains(e)) ...[
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
                              ),
                            )
                          ],
                        ),
                      ),
                  ))
                  .toList(),
            )
          : const Center(child: Text('No Bookmarks added yet')),
    );
  }
}