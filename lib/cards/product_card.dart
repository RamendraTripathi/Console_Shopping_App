import 'package:flutter/material.dart';
import 'package:shop_app_flutter/pages/product_details_page.dart';

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final String productName;
  final List<String> productSize;
  final double productPrice;
  final String productDescription;
  final String imageURL;
  final bool backgroundColorIndex;

  ProductCard({
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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ProductDetailsPage(
                    productName: widget.productName,
                    productPrice: widget.productPrice,
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
              children: [
                Text(
                  widget.productName,
                  style:
                      Theme.of(
                        context,
                      ).textTheme.titleMedium,
                ),
                const SizedBox(height: 15),
                Image(
                  image: AssetImage(widget.imageURL),
                  height: 275,
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 10,
                  children: [
                    for (
                      int i = 0;
                      i < widget.productSize.length;
                      i++
                    )
                      ChoiceChip(
                        label: Text(widget.productSize[i]),
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
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  '\$ ${widget.productPrice}',
                  style:
                      Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 15),
                TextButton(
                  style: ButtonStyle(
                    maximumSize: WidgetStateProperty.all(
                      Size(140, 40),
                    ),
                    backgroundColor:
                        WidgetStateProperty.all(
                          const Color.fromARGB(
                            255,
                            238,
                            240,
                            243,
                          ),
                        ),
                  ),
                  onPressed: () {
                    print('Button Pressed!');
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
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                          ),
                        ),
                        Icon(
                          Icons.shopping_cart,
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
