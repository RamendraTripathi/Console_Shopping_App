import 'package:flutter/material.dart';
import 'package:shop_app_flutter/providers/dummy_data/global_variables.dart';
import '../../widgets/product_card.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final List<String> filters = const [
    'All',
    'Microsoft',
    'Sony',
    'Nintendo',
    'Valve',
    'Asus',
  ];

  int selectedFilter = 0;
  String selectedFilterName = 'All';

  int _column = 1;
  bool isOnMobile = false;

  @override
  Widget build(BuildContext context) {
    // making the shopping grid flexible using media query

    final screenSize = MediaQuery.of(context).size.width;
    double minProductCardWidth = isOnMobile ? 250 : 350;

    // calculates the required no. of columns by measuring width of screen(dynamic) and minimum size of the card (static).

    int crossAxisCount =
        (screenSize / minProductCardWidth)
            .floor(); // floor - Returns the greatest integer no greater than this number.

    double childAspectRatio = 0.67;

    switch (crossAxisCount) {
      case 1:
        childAspectRatio = 0.55;
      // childAspectRatio = _column == 1 ? 0.67 : 0.55;
      case 2:
        childAspectRatio = .8;
    }

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _headerBuilder(),
            _filterBuilder(crossAxisCount),
            _shoppingCardsBuilder(
              crossAxisCount,
              childAspectRatio,
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerBuilder() {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(30),
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Console\nCollection',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Icon(Icons.search),
              ),

              hintText: 'Search',
              contentPadding: EdgeInsets.symmetric(
                vertical: 27.0,
                horizontal: 27.0,
              ),
              border: border,
              focusedBorder: border,
              enabledBorder: border,
            ),
          ),
        ),
      ],
    );
  }

  Widget _filterBuilder(final crossAxisCount) {
    return Row(
      children: [
        Flexible(
          flex: 6,
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Chip(
                      elevation: 10,
                      backgroundColor:
                          selectedFilter == index
                              ? const Color.fromARGB(
                                255,
                                252,
                                224,
                                179,
                              )
                              : const Color.fromARGB(
                                255,
                                238,
                                240,
                                243,
                              ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      side: BorderSide(
                        color: const Color.fromARGB(
                          255,
                          238,
                          240,
                          243,
                        ),
                      ),
                      label: Text(filters[index]),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      labelPadding: EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 10,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedFilter = index;
                        selectedFilterName = filters[index];
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          flex: 1,
          child:
              MediaQuery.of(context).size.width < 650
                  ? Padding(
                    padding: const EdgeInsets.only(
                      right: 10.0,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        color: const Color.fromARGB(
                          255,
                          216,
                          253,
                          242,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (isOnMobile) {
                              isOnMobile = false;
                            } else {
                              isOnMobile = true;
                            }
                          });
                          // if (_column > 1) {
                          //   setState(() {
                          //     _column = 1;
                          //   });
                          // } else {
                          //   setState(() {
                          //     _column = 2;
                          //   });
                          // }
                        },
                        icon:
                            isOnMobile
                                ? Icon(Icons.menu)
                                : Icon(
                                  Icons.grid_view_rounded,
                                ),
                      ),
                    ),
                  )
                  : Padding(padding: EdgeInsets.all(0)),
        ),
      ],
    );
  }

  Widget _shoppingCardsBuilder(
    final crossAxisCount,
    final childAspectRatio,
  ) {
    return // Building the Shopping Cards
    ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 50,
      ),
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
            ),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: getFilteredProducts().length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),

            child: ProductCard(
              columnCount: crossAxisCount,
              product: getFilteredProducts()[index],
              backgroundColorIndex:
                  index % 2 == 0 ? true : false,
            ),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> getFilteredProducts() {
    if (selectedFilterName == 'All') {
      return product;
    }
    final list =
        product
            .where(
              (prod) =>
                  prod['company'] == selectedFilterName,
            )
            .toList();
    return list;
  }
}
