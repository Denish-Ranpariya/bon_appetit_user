import 'package:flutter/material.dart';
class MenuScreen extends StatefulWidget {
  final String restaurantId;

  MenuScreen({this.restaurantId});
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.restaurantId),
    );
  }
}