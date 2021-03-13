import 'package:bon_appetit_user/models/food_item.dart';
import 'package:bon_appetit_user/services/database_service.dart';
import 'package:bon_appetit_user/shared/constants.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final Map<FoodItem, int> cart;

  CartScreen({this.cart});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int total = 0;

  void calculateTotal() {
    setState(() {
      widget.cart.forEach((key, value) {
        total += int.parse(key.foodItemPrice) * value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    total = 0;
    calculateTotal();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: kScreenHeadingTextStyle,
        ),
        backgroundColor: Color(0xFFc9e3db),
        iconTheme: IconThemeData(color: Colors.grey[700]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await DatabaseService().placeOrder(widget.cart);
          setState(() {
            widget.cart.clear();
          });
          Navigator.pop(context);
        },
        label: Text("Amount: ₹$total"),
      ),
      body: widget.cart.length == 0
          ? Center(
              child: Container(
              child: Text(
                'Cart is empty',
                style: kScreenHeadingTextStyle.copyWith(letterSpacing: 1.3),
              ),
            ))
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundColor: widget.cart.keys
                                          .elementAt(index)
                                          .foodItemType ==
                                      'nonveg'
                                  ? Colors.red
                                  : Colors.green,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                backgroundImage: widget.cart.keys
                                            .elementAt(index)
                                            .foodItemImageUrl ==
                                        ''
                                    ? AssetImage('images/default.jpeg')
                                    : NetworkImage(widget.cart.keys
                                        .elementAt(index)
                                        .foodItemImageUrl),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                widget.cart.keys
                                        .elementAt(index)
                                        .foodItemName ??
                                    '',
                                style: kTileTextStyle,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "₹" +
                                  (widget.cart.keys
                                          .elementAt(index)
                                          .foodItemPrice ??
                                      '') +
                                  " X " +
                                  (widget
                                      .cart[widget.cart.keys.elementAt(index)]
                                      .toString()),
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: widget.cart.length,
            ),
    );
  }
}
