import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/pages/child_pages/product_details_page.dart';

class CartCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final String productName;
  final String productSize;
  final double productPrice;
  final String productDescription;
  final String imageURL;
  final bool backgroundColorIndex;

  CartCard({
    super.key,
    required this.product,
    required this.backgroundColorIndex,
  }) : productName = product['title'] as String,
       productSize = product['disk size'] as String,
       productPrice = product['price'] as double,
       productDescription =
           product['description'] as String,
       imageURL = product['imgUrl'] as String;

  @override
  State<CartCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<CartCard> {
  int selectedSize = 0;

  void removeItem() {
    if (Provider.of<CartProvider>(
      context,
      listen: false,
    ).cart.any(
      (item) => item['id'] == widget.product['id'],
    )) {
      Provider.of<CartProvider>(
        context,
        listen: false,
      ).removeProduct(widget.product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color:
              widget.backgroundColorIndex
                  ? const Color.fromRGBO(216, 240, 253, 1)
                  : const Color.fromARGB(
                    255,
                    216,
                    253,
                    242,
                  ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ProductDetailsPage(
                            product: widget.product,
                            backgroundColorIndex:
                                widget.backgroundColorIndex,
                          ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 18.0,
                  ),
                  child: Image(
                    image: AssetImage(widget.imageURL),
                    height: 145,
                    width: 135,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName,

                      style:
                          Theme.of(
                            context,
                          ).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                    ),
                    Text(
                      '\$ ${(widget.productPrice * widget.product['count']).toStringAsFixed(2)}',
                      style:
                          Theme.of(
                            context,
                          ).textTheme.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 9.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                            255,
                            238,
                            240,
                            243,
                          ),
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (widget
                                        .product['count'] <
                                    10) {
                                  Provider.of<CartProvider>(
                                    context,
                                    listen: false,
                                  ).incrementCount(
                                    widget.product,
                                  );
                                }
                              },
                              icon: Icon(Icons.add),
                            ),
                            Text(
                              widget.product['count']
                                  .toString(),
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleSmall,
                            ),
                            IconButton(
                              onPressed: () {
                                if (widget
                                        .product['count'] >
                                    1) {
                                  Provider.of<CartProvider>(
                                    context,
                                    listen: false,
                                  ).decrementCount(
                                    widget.product,
                                  );
                                } else if (widget
                                        .product['count'] ==
                                    1) {
                                  Provider.of<CartProvider>(
                                    context,
                                    listen: false,
                                  ).removeProduct(
                                    widget.product,
                                  );
                                }
                              },
                              icon:
                                  widget.product['count'] !=
                                          1
                                      ? Icon(Icons.remove)
                                      : Icon(
                                        Icons.delete,
                                        color:
                                            Colors
                                                .redAccent,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
