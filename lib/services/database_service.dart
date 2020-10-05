import 'package:bon_appetit_user/models/food_item.dart';
import 'package:bon_appetit_user/models/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String id;
  DatabaseService({this.id});

  Stream<List<FoodItem>> get foodItems {
    String foodItemCollectionName = id;
    final CollectionReference foodItemCollection =
        Firestore.instance.collection(foodItemCollectionName);
    return foodItemCollection.snapshots().map(_foodItemsListFromSnapshot);
  }

  //to get the data form firestore to fooditem model by mapping
  List<FoodItem> _foodItemsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return FoodItem(
        foodItemId: doc.data['fooditem_id'],
        foodItemName: doc.data['fooditem_name'],
        foodItemPrice: doc.data['fooditem_price'],
        foodItemCategory: doc.data['fooditem_category'],
        foodItemDescription: doc.data['fooditem_description'],
        foodItemType: doc.data['fooditem_type'],
      );
    }).toList();
  }

  Stream<Restaurant> get restaurantData {
    return Firestore.instance
        .collection('restaurants')
        .document(id.substring(0, 28))
        .snapshots()
        .map(_restaurantDataFromSnapshot);
  }

  Restaurant _restaurantDataFromSnapshot(DocumentSnapshot snapshot) {
    return Restaurant(
        restaurantName: snapshot.data['restaurant_name'],
        restaurantPhoneNumber: snapshot.data['phone_number']);
  }
}
