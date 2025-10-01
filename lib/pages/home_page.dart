import 'package:flutter/material.dart';
import 'package:shop_app_flutter/pages/main_Pages/cart_page.dart';
import 'package:shop_app_flutter/pages/main_Pages/orders_page.dart';
import 'package:shop_app_flutter/pages/main_Pages/shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;
  List<Widget> pages = [
    OrdersPage(),
    ShopPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedIconTheme: IconThemeData(
          color: const Color.fromARGB(255, 147, 183, 236),
        ),
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
            label: 'You',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Shop',
            icon: Icon(Icons.shopping_bag),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.shopping_cart),
          ),
        ],
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}
