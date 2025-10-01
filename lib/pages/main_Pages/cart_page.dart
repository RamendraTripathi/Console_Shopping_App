import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shop_app_flutter/cards/cart_card.dart';
import 'package:shop_app_flutter/dummy_data/global_variables.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _showMessage = false;
  bool _isLoading = false;

  List<Map<String, dynamic>> cartList = cart;

  void showQuickMessage() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      _showMessage = true;
    });
    Future.delayed(
      Duration(seconds: 3),
      () => setState(() {
        _showMessage = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Cart')),
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                        MediaQuery.of(context).size.width -
                        50,
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                          255,
                          252,
                          224,
                          179,
                        ),

                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                                        Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                    maxLines: 2,
                                    overflow:
                                        TextOverflow
                                            .ellipsis,
                                  ),
                                  Text(
                                    '\$ ',
                                    style:
                                        Theme.of(context)
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
                                setState(() {
                                  showQuickMessage();
                                });
                              },
                              child: Text(
                                'Buy Items',
                                style:
                                    Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
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
                  child: CircularProgressIndicator(),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100.0,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        252,
                        224,
                        179,
                      ),
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          'Items Ordered!',
                          style:
                              Theme.of(
                                context,
                              ).textTheme.titleSmall,
                        ),

                        // Row(
                        //   children: [
                        //     Text(
                        //       '...',
                        //       style:
                        //           Theme.of(
                        //             context,
                        //           ).textTheme.titleSmall,
                        //     ),
                        //     Icon(Icons.delivery_dining),
                        //   ],
                        // ),
                      ],
                    ),
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
