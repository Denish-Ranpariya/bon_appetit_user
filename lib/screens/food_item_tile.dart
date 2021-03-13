import 'package:bon_appetit_user/models/food_item.dart';
import 'package:bon_appetit_user/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodItemTile extends StatelessWidget {
  final FoodItem foodItem;

  FoodItemTile({this.foodItem});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ExpansionTile(
        title: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor:
                  foodItem.foodItemType == 'nonveg' ? Colors.red : Colors.green,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: foodItem.foodItemImageUrl == ''
                    ? AssetImage('images/default.jpeg')
                    : NetworkImage(foodItem.foodItemImageUrl),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                foodItem.foodItemName ?? '',
                style: kTileTextStyle,
              ),
            ),
          ],
        ),
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: Text(
              "Price : ₹" + foodItem.foodItemPrice ?? '',
              style: kTileTextStyle,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: Text(
              "Description : " + foodItem.foodItemDescription ?? '',
              style: kTileTextStyle,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
