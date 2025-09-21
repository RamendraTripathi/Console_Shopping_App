import 'package:flutter/material.dart';
import 'package:shop_app_flutter/global_variables.dart';
import '../cards/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(30),
      ),
    );
    return Scaffold(
      body: SafeArea(
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
                        contentPadding:
                            EdgeInsets.symmetric(
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
              SizedBox(
                height: 100,
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
                            borderRadius:
                                BorderRadius.circular(20),
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
                                vertical: 10,
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
              // Card(
              //   color: const Color.fromARGB(
              //     255,
              //     219,
              //     220,
              //     223,
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(18.0),
              //     child: Column(
              //       children: [
              //         Text(product[0]['title'].toString()),
              //         Text(product[0]['price'].toString()),
              //       ],
              //     ),
              //   ),
              // ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      MediaQuery.of(context).size.width -
                      50,
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: getFilteredProducts().length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),

                      child: ProductCard(
                        product:
                            getFilteredProducts()[index],
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
