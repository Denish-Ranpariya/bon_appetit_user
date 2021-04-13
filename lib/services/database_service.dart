import 'package:bon_appetit_user/models/Order.dart';
import 'package:bon_appetit_user/models/food_item.dart';
import 'package:bon_appetit_user/models/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:random_string/random_string.dart';

class DatabaseService {
  String id;
  DatabaseService({this.id});

  Stream<List<FoodItem>> get foodItems {
    final CollectionReference foodItemCollection =
        FirebaseFirestore.instance.collection(id);
    return foodItemCollection.snapshots().map(_foodItemsListFromSnapshot);
  }

  //to get the data form firestore to fooditem model by mapping
  List<FoodItem> _foodItemsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodItem(
        foodItemId: doc.get('fooditem_id'),
        foodItemName: doc.get('fooditem_name'),
        foodItemPrice: doc.get('fooditem_price'),
        foodItemCategory: doc.get('fooditem_category'),
        foodItemDescription: doc.get('fooditem_description'),
        foodItemType: doc.get('fooditem_type'),
        foodItemImageUrl: doc.get('fooditem_image'),
      );
    }).toList();
  }

  Stream<Restaurant> get restaurantData {
    return FirebaseFirestore.instance
        .collection('restaurants')
        .doc(id.substring(0, 28))
        .snapshots()
        .map(_restaurantDataFromSnapshot);
  }

  Restaurant _restaurantDataFromSnapshot(DocumentSnapshot snapshot) {
    return Restaurant(
        restaurantName: snapshot.get('restaurant_name'),
        restaurantPhoneNumber: snapshot.get('phone_number'));
  }

  Future placeOrder(Map<FoodItem, int> cart, String restaurantId) async {
    String orderId = randomAlphaNumeric(22);
    String name = FirebaseAuth.instance.currentUser.displayName;

    await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser.uid + 'order')
        .doc(orderId)
        .set({
          'name': name,
          'order_id': orderId,
        });
    cart.forEach((key, value) async {
      return await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser.uid + 'order')
          .doc(orderId)
          .collection("ordered_fooditems_collection")
          .doc()
          .set({
        'fooditem_name': key.foodItemName,
        'fooditem_price': key.foodItemPrice,
        'fooditem_quantity': value,
      });
    });

    await FirebaseFirestore.instance
        .collection(restaurantId.substring(0, restaurantId.length - 4) +
            'pendingorders')
        .doc(orderId)
        .set({
          'name': name,
          'order_id': orderId,
        });
    cart.forEach((key, value) async {
      return await FirebaseFirestore.instance
          .collection(restaurantId.substring(0, restaurantId.length - 4) +
              'pendingorders')
          .doc(orderId)
          .collection("ordered_fooditems_collection")
          .doc()
          .set({
        'fooditem_name': key.foodItemName,
        'fooditem_price': key.foodItemPrice,
        'fooditem_quantity': value,
      });
    });
  }

  Stream<List<Order>> get getPendingOrdersList  {
    String collectionPath = id + "order";
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection(collectionPath);
    return collectionReference.snapshots().map(_orderList);
  }

  List<Order> _orderList(QuerySnapshot querySnapshot)  {
    return querySnapshot.docs.map((document){
      return Order(
        name: document.get('name'),
        orderId: document.get('order_id'),
      );
    }).toList();
  }
}
