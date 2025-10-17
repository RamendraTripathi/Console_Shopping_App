import 'package:flutter/material.dart';
import 'package:shop_app_flutter/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';
import 'package:flutter/services.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Map<String, dynamic>> order = [];

  @override
  Widget build(BuildContext context) {
    order = Provider.of<CartProvider>(context).orders;
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

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      child: Dismissible(
                        key: ValueKey(order[index]['id']),
                        direction:
                            DismissDirection.endToStart,

                        onDismissed: (direction) {
                          HapticFeedback.mediumImpact();
                          setState(() {
                            order.remove(order[index]);
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Order Canceled.',
                                ),
                              ),
                            );
                          });
                        },
                        background: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cancel Order?',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              SizedBox(height: 5),
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          color:
                              index % 2 == 0
                                  ? const Color.fromRGBO(
                                    216,
                                    240,
                                    253,
                                    1,
                                  )
                                  : const Color.fromARGB(
                                    255,
                                    216,
                                    253,
                                    242,
                                  ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                cartItem['imgUrl']
                                    as String,
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
                            trailing: Text(
                              'Status: Dispatching',
                            ),
                            // trailing: TextButton.icon(
                            //   onPressed: () {
                            //     setState(() {
                            //       order.remove(order[index]);
                            //     });
                            //   },
                            //   icon: Icon(
                            //     Icons.cancel_rounded,
                            //     color: Colors.redAccent,
                            //   ),
                            //   label: Text('Cancel Order?'),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
