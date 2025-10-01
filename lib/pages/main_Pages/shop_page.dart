import 'package:flutter/material.dart';
import 'package:shop_app_flutter/dummy_data/global_variables.dart';
import '../../../cards/product_card.dart';

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

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(30),
      ),
    );
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
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
                        padding: const EdgeInsets.only(
                          left: 15.0,
                        ),
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
            ),
            Row(
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
                          padding: const EdgeInsets.all(
                            8.0,
                          ),
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
                                borderRadius:
                                    BorderRadius.circular(
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
                              labelPadding:
                                  EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 10,
                                  ),
                            ),
                            onTap: () {
                              setState(() {
                                selectedFilter = index;
                                selectedFilterName =
                                    filters[index];
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
                  child: Padding(
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
                          if (_column == 1) {
                            setState(() {
                              _column = 2;
                            });
                          } else {
                            setState(() {
                              _column = 1;
                            });
                          }
                        },
                        icon:
                            _column == 1
                                ? Icon(Icons.menu)
                                : Icon(
                                  Icons.grid_view_rounded,
                                ),
                      ),

                      // PopupMenuButton<int>(
                      //   elevation: 10,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius:
                      //         BorderRadius.circular(10),
                      //   ),
                      //   color: const Color.fromARGB(
                      //     255,
                      //     216,
                      //     253,
                      //     242,
                      //   ),
                      //   icon: Icon(Icons.grid_view_rounded),
                      //   onSelected: (value) {
                      //     setState(() {
                      //       _column = value;
                      //     });
                      //   },
                      //   itemBuilder:
                      //       (context) => [
                      //         PopupMenuItem(
                      //           value: 1,
                      //           child: Text(
                      //             'List View',
                      //             style: TextStyle(
                      //               fontWeight:
                      //                   FontWeight.bold,
                      //             ),
                      //           ),
                      //         ),
                      //         PopupMenuItem(
                      //           value: 2,
                      //           child: Text(
                      //             'Grid View',
                      //             style: TextStyle(
                      //               fontWeight:
                      //                   FontWeight.bold,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      // ),
                    ),
                  ),
                ),
              ],
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:
                    MediaQuery.of(context).size.width - 50,
              ),
              child: GridView.builder(
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _column == 1 ? 1 : 2,
                      childAspectRatio:
                          _column == 1 ? 0.67 : 0.55,
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
                      columnCount: _column,
                      product: getFilteredProducts()[index],
                      backgroundColorIndex:
                          index % 2 == 0 ? true : false,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
