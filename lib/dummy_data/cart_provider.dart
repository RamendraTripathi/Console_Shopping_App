import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cart = [];
  final List<Map<String, dynamic>> orders = [];

  void addProduct(Map<String, dynamic> product) {
    cart.add(product);
    print('\n--Item Added; $cart\n\n');
    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    // print('\n--Item Removed: $cart\n');
    notifyListeners();
  }

  void incrementCount(Map<String, dynamic> product) {
    final itemIndex = cart.indexWhere(
      (item) => item['id'] == product['id'],
    );
    if (itemIndex != -1) {
      cart[itemIndex]['count'] =
          (cart[itemIndex]['count'] ?? 0) + 1;
      notifyListeners();
    }
  }

  void decrementCount(Map<String, dynamic> product) {
    final itemIndex = cart.indexWhere(
      (item) => item['id'] == product['id'],
    );
    if (itemIndex != -1) {
      cart[itemIndex]['count'] =
          (cart[itemIndex]['count'] ?? 0) - 1;
      notifyListeners();
    }
  }

  double calculateTotal() {
    double subTotal = 0;
    for (int i = 0; i < cart.length; i++) {
      double itemTotalCost = 0;
      if (cart[i]['count'] > 1) {
        itemTotalCost = cart[i]['count'] * cart[i]['price'];
      }
      itemTotalCost == 0
          ? subTotal += cart[i]['price']
          : subTotal += itemTotalCost;
    }

    return subTotal;
  }

  orderItems() {
    orders.addAll(cart);
    cart.clear();
    notifyListeners();
  }
}
