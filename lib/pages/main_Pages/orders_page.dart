import 'package:flutter/material.dart';
import 'package:shop_app_flutter/dummy_data/global_variables.dart';
import 'package:shop_app_flutter/pages/home_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      body:
          order.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      'You haven\'t placed any orders yet.',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => HomePage(),
                            ),
                          );
                        },
                        child: Text(
                          'Shop Now',
                          style:
                              Theme.of(
                                context,
                              ).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: order.length,
                itemBuilder: (context, index) {
                  final cartItem = order[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        cartItem['imgUrl'] as String,
                      ),
                      radius: 45,
                    ),
                    title: Text(
                      cartItem['title'].toString(),
                      style:
                          Theme.of(
                            context,
                          ).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      'Size: ${cartItem['disk size'].toString()}',
                    ),
                  );
                },
              ),
    );
  }
}
