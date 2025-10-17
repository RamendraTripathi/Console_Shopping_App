import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_flutter/widgets/cart_card.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _showMessage = false;
  bool _isLoading = false;

  List<Map<String, dynamic>> cartList = [];

  double getTotal() {
    return Provider.of<CartProvider>(
      context,
      listen: false,
    ).calculateTotal();
  }

  Future<void> showQuickMessage() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      _showMessage = true;
    });
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showMessage = false;
      });
    });
    orderItems();
  }

  void orderItems() {
    Provider.of<CartProvider>(
      context,
      listen: false,
    ).orderItems();
  }

  @override
  Widget build(BuildContext context) {
    cartList = Provider.of<CartProvider>(context).cart;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Cart')),
        body:
            cartList.isEmpty
                ? Center(child: Text('You cart is empty'))
                : Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth:
                                MediaQuery.of(
                                  context,
                                ).size.width -
                                50,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics:
                                NeverScrollableScrollPhysics(),
                            itemCount: cartList.length,
                            itemBuilder: (context, index) {
                              return CartCard(
                                product: cartList[index],
                                backgroundColorIndex:
                                    index % 2 == 0
                                        ? true
                                        : false,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                              15.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(
                                  255,
                                  252,
                                  224,
                                  179,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                      16,
                                    ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(
                                      15.0,
                                    ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        children: [
                                          Text(
                                            'Subtotal',
                                            style:
                                                Theme.of(
                                                      context,
                                                    )
                                                    .textTheme
                                                    .titleMedium,
                                            maxLines: 2,
                                            overflow:
                                                TextOverflow
                                                    .ellipsis,
                                          ),
                                          Text(
                                            '\$ ${getTotal().toStringAsFixed(2)}',
                                            style:
                                                Theme.of(
                                                      context,
                                                    )
                                                    .textTheme
                                                    .titleMedium,
                                            maxLines: 2,
                                            overflow:
                                                TextOverflow
                                                    .ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        showQuickMessage();
                                      },
                                      child: Text(
                                        'Buy Items',
                                        style:
                                            Theme.of(
                                                  context,
                                                )
                                                .textTheme
                                                .titleSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_showMessage || _isLoading)
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5.0,
                            sigmaY: 5.0,
                          ),
                          child: Container(
                            color: Colors.white.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                      ),
                    if (_isLoading)
                      Center(
                        child: Positioned.fill(
                          child:
                              CircularProgressIndicator(),
                        ),
                      )
                    else
                      Padding(padding: EdgeInsets.all(0)),
                    if (_showMessage)
                      Positioned(
                        top: 450,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                horizontal: 100.0,
                              ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(
                                        255,
                                        252,
                                        224,
                                        179,
                                      ),
                                  borderRadius:
                                      BorderRadius.circular(
                                        16,
                                      ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                  children: [
                                    Text(
                                      'Items Ordered!',
                                      style:
                                          Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(
                                      18.0,
                                    ),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(
                                          const Color.fromARGB(
                                            255,
                                            252,
                                            224,
                                            179,
                                          ),
                                        ),
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: Text(
                                    'Ok',
                                    style:
                                        Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Padding(padding: EdgeInsets.all(0)),
                  ],
                ),
      ),
    );
  }
}
