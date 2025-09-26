import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productName;
  final List<String> productSize;
  final double productPrice;
  final String productDescription;
  final String imageURL;
  final bool backgroundColorIndex;
  const ProductDetailsPage({
    super.key,
    required this.productName,
    required this.productSize,
    required this.productPrice,
    required this.productDescription,
    required this.imageURL,
    required this.backgroundColorIndex,
  });

  @override
  State<ProductDetailsPage> createState() =>
      _ProductDetailsPageState();
}

class _ProductDetailsPageState
    extends State<ProductDetailsPage> {
  int selectedSize = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Product Details',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style:
                        Theme.of(
                          context,
                        ).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 375,
                    child: Image(
                      image: AssetImage(widget.imageURL),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'Product Details',
                    style:
                        Theme.of(
                          context,
                        ).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.productDescription,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),
                  Wrap(
                    spacing: 10,
                    children: [
                      for (
                        int i = 0;
                        i < widget.productSize.length;
                        i++
                      )
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                          child: ChoiceChip(
                            label: Text(
                              widget.productSize[i],
                            ),
                            side: BorderSide.none,
                            backgroundColor:
                                const Color.fromARGB(
                                  255,
                                  238,
                                  240,
                                  243,
                                ),
                            selected: selectedSize == i,
                            onSelected: (selected) {
                              setState(() {
                                selectedSize = i;
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '\$ ${widget.productPrice}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      style: ButtonStyle(
                        maximumSize:
                            WidgetStateProperty.all(
                              Size(190, 60),
                            ),
                        minimumSize:
                            WidgetStateProperty.all(
                              Size(100, 60),
                            ),
                        backgroundColor:
                            WidgetStateProperty.all(
                              const Color.fromRGBO(
                                216,
                                240,
                                253,
                                1,
                              ),
                            ),
                      ),
                      onPressed: () {
                        print('Item added to cart');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                              ),
                            ),
                            Icon(
                              Icons.shopping_cart,
                              size: 20,
                              color:
                                  Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
