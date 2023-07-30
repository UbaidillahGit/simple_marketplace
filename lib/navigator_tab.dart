import 'package:flutter/material.dart';
import 'package:simple_marketplace/features/bookmark/presentation/bookmark_page.dart';
import 'package:simple_marketplace/features/explore/presentation/explore_page.dart';
import 'package:simple_marketplace/features/orders/presentation/orders_page.dart';

class NavigatorTab extends StatefulWidget {
  const NavigatorTab({super.key});

  @override
  State<NavigatorTab> createState() => _NavigatorTabState();
}

class _NavigatorTabState extends State<NavigatorTab> {
 int _selectedMenuIndex = 0;
  
  final List<Widget> _menu = [
    const ExplorePage(),
    const BookmarkPage(),
    const OrdersPage(),
  ];

  final List<BottomNavigationBarItem> _bottomBar =  [
    const BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      label: 'Explore',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bookmark),
      label: 'Bookmark',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      label: 'Orders',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _setMenu(int idx) {
    setState(() {
      _selectedMenuIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _menu[_selectedMenuIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedMenuIndex,
        items: _bottomBar,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        selectedItemColor: const Color(0xFF2495AC),
        unselectedItemColor: Colors.grey,
        onTap: _setMenu
      ),
    );
  }
}