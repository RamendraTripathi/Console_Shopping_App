import 'package:flutter/material.dart';
import 'package:shop_app_flutter/pages/product_details_page.dart';

class CartCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final String productName;
  final List<String> productSize;
  final double productPrice;
  final String productDescription;
  final String imageURL;
  final bool backgroundColorIndex;
  int productQuantity = 1;

  CartCard({
    super.key,
    required this.product,
    required this.backgroundColorIndex,
  }) : productName = product['title'] as String,
       productSize = product['disk size'] as List<String>,
       productPrice = product['price'] as double,
       productDescription =
           product['description'] as String,
       imageURL = product['imgUrl'] as String;

  @override
  State<CartCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<CartCard> {
  int selectedSize = 0;

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
                      '\$ ${(widget.productPrice * widget.productQuantity).toStringAsFixed(2)}',
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
                        margin: EdgeInsets.only(right: 60),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (widget
                                          .productQuantity <
                                      10) {
                                    widget.productQuantity +=
                                        1;
                                  }
                                });
                              },
                              icon: Icon(Icons.add),
                            ),
                            Text(
                              widget.productQuantity
                                  .toString(),
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleSmall,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (widget
                                          .productQuantity >
                                      1) {
                                    widget.productQuantity -=
                                        1;
                                  }
                                });
                              },
                              icon: Icon(Icons.remove),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ProductDetailsPage(
                            productName: widget.productName,
                            productPrice:
                                widget.productPrice,
                            productSize: widget.productSize,
                            productDescription:
                                widget.productDescription,
                            imageURL: widget.imageURL,
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
            ],
          ),
        ),
      ),
    );
  }
}
