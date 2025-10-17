import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final String productName;
  final List<String> productSize;
  final double productPrice;
  final String productDescription;
  final String imageURL;
  final bool backgroundColorIndex;

  ProductDetailsPage({
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
  State<ProductDetailsPage> createState() =>
      _ProductDetailsPageState();
}

class _ProductDetailsPageState
    extends State<ProductDetailsPage> {
  int selectedSize = 0;

  void onTap() {
    Provider.of<CartProvider>(
          context,
          listen: false,
        ).cart.any(
          (item) => item['id'] == widget.product['id'],
        )
        ? Provider.of<CartProvider>(
          context,
          listen: false,
        ).incrementCount(widget.product)
        : Provider.of<CartProvider>(
          context,
          listen: false,
        ).addProduct({
          'id': widget.product['id'],
          'company': widget.product['company'],
          'title': widget.product['title'],
          'description': widget.product['description'],
          'price': widget.product['price'],
          'disk size':
              widget.product['disk size'][selectedSize],
          'imgUrl': widget.product['imgUrl'],
          'count': 1,
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child:
                size.width > 650
                    ? Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
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
                                  image: AssetImage(
                                    widget.imageURL,
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
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
                                textAlign:
                                    TextAlign.justify,
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
                                    i <
                                        widget
                                            .productSize
                                            .length;
                                    i++
                                  )
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 5.0,
                                          ),
                                      child: ChoiceChip(
                                        label: Text(
                                          widget
                                              .productSize[i],
                                        ),
                                        side:
                                            BorderSide.none,
                                        selectedColor:
                                            const Color.fromARGB(
                                              255,
                                              252,
                                              224,
                                              179,
                                            ),
                                        backgroundColor:
                                            const Color.fromARGB(
                                              255,
                                              238,
                                              240,
                                              243,
                                            ),
                                        selected:
                                            selectedSize ==
                                            i,
                                        onSelected: (
                                          selected,
                                        ) {
                                          setState(() {
                                            selectedSize =
                                                i;
                                          });
                                        },
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                '\$ ${widget.productPrice}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight:
                                          FontWeight.bold,
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
                                          const Color.fromARGB(
                                            255,
                                            252,
                                            224,
                                            179,
                                          ),
                                        ),
                                  ),
                                  onPressed: () {
                                    onTap();
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Item added to cart',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(
                                          0,
                                        ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly,
                                      children: [
                                        Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                            color:
                                                Theme.of(
                                                      context,
                                                    )
                                                    .colorScheme
                                                    .onPrimaryContainer,
                                          ),
                                        ),
                                        Icon(
                                          Icons
                                              .shopping_cart,
                                          size: 20,
                                          color:
                                              Theme.of(
                                                    context,
                                                  )
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
                        ],
                      ),
                    )
                    : Column(
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
                            image: AssetImage(
                              widget.imageURL,
                            ),
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
                                  selectedColor:
                                      const Color.fromARGB(
                                        255,
                                        252,
                                        224,
                                        179,
                                      ),
                                  backgroundColor:
                                      const Color.fromARGB(
                                        255,
                                        238,
                                        240,
                                        243,
                                      ),
                                  selected:
                                      selectedSize == i,
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
                                    const Color.fromARGB(
                                      255,
                                      252,
                                      224,
                                      179,
                                    ),
                                  ),
                            ),
                            onPressed: () {
                              onTap();
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Item added to cart',
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(
                                0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceEvenly,
                                children: [
                                  Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight:
                                          FontWeight.bold,
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
    );
  }
}
