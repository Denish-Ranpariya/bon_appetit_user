import 'package:bon_appetit_user/models/food_item.dart';
import 'package:bon_appetit_user/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodItemTile extends StatefulWidget {
  final FoodItem foodItem;
  FoodItemTile({this.foodItem});
  @override
  _FoodItemTileState createState() => _FoodItemTileState();
}

class _FoodItemTileState extends State<FoodItemTile> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor:
                  widget.foodItem.foodItemType == 'nonveg' ? Colors.red : Colors.green,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    backgroundImage: widget.foodItem.foodItemImageUrl == ''
                        ? AssetImage('images/default.jpeg')
                        : NetworkImage(widget.foodItem.foodItemImageUrl),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    widget.foodItem.foodItemName ?? '',
                    style: kTileTextStyle,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // count == 0 ? count = 0 : count--;
                    setState(() {
                      count = count == 0 ? 0 : count-1;
                    });
                  },
                  child: Text(
                    '-',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
                SizedBox(width: 10.0,),
                Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(width: 10.0,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      count++;
                    });
                  },
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(width: 10.0,),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: Text(
              "Price : ₹" + widget.foodItem.foodItemPrice ?? '',
              style: kTileTextStyle,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: Text(
              "Description : " + widget.foodItem.foodItemDescription ?? '',
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