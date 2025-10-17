import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';
import 'package:shop_app_flutter/pages/child_pages/product_details_page.dart';

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final String productName;
  final List<String> productSize;
  final double productPrice;
  final String productDescription;
  final String imageURL;
  final bool backgroundColorIndex;
  final int columnCount;

  ProductCard({
    super.key,
    required this.product,
    required this.backgroundColorIndex,
    required this.columnCount,
  }) : productName = product['title'] as String,
       productSize = product['disk size'] as List<String>,
       productPrice = product['price'] as double,
       productDescription =
           product['description'] as String,
       imageURL = product['imgUrl'] as String;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int selectedSize = 0;

  void onTap() {
    print(widget.product['disk size'][selectedSize]);
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
    double parentDimension = 200;

    switch (widget.columnCount) {
      case 1:
        parentDimension = 375;
      case > 2:
        parentDimension = 275;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                ConstrainedBox(
                  constraints: BoxConstraints.expand(
                    height: parentDimension,
                    width: parentDimension,
                  ),
                  child: Image(
                    image: AssetImage(widget.imageURL),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Column(
                  children: [
                    Wrap(
                      spacing: 10,
                      children: [
                        for (
                          int i = 0;
                          i < widget.productSize.length;
                          i++
                        )
                          ChoiceChip(
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
                            selected: selectedSize == i,
                            onSelected: (selected) {
                              setState(() {
                                selectedSize = i;
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '\$ ${widget.productPrice}',
                      style:
                          Theme.of(
                            context,
                          ).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
                TextButton(
                  style: ButtonStyle(
                    maximumSize: WidgetStateProperty.all(
                      widget.columnCount == 1
                          ? Size(140, 40)
                          : Size(100, 40),
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
                        content: Text('Item added to cart'),
                      ),
                    );
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
                            fontSize:
                                widget.columnCount == 1
                                    ? 15
                                    : 11,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                          ),
                        ),
                        Icon(
                          Icons.shopping_cart,
                          size:
                              widget.columnCount == 1
                                  ? 15
                                  : 12,
                          color:
                              Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                        ),
                      ],
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
