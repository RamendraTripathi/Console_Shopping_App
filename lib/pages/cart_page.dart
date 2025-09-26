import 'package:flutter/material.dart';
import 'package:shop_app_flutter/cards/cart_card.dart';
import 'package:shop_app_flutter/cards/product_card.dart';
import 'package:shop_app_flutter/Dummy Data/global_variables.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartList = cart;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:
                    MediaQuery.of(context).size.width - 50,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  return CartCard(
                    product: cartList[index],
                    backgroundColorIndex:
                        index % 2 == 0 ? true : false,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
