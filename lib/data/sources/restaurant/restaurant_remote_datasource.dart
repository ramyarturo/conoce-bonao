import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conoce_bonao/constants/firebase.dart';
import 'package:conoce_bonao/models/restaurant.dart';

abstract class IRestaurantDataSource {
  Future<List<RestaurantModel>> getRestaurants();
  Future<RestaurantModel> getRestaurantById(String id);
}

class RestaurantRemoteDataSource implements IRestaurantDataSource {
  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    final queryDocuments = await firebaseFirestore.collection(restaurantCollection).get();
    final restaurants = queryDocuments.docs.map(_docMap).toList();
    return restaurants.toList();
  }

  @override
  Future<RestaurantModel> getRestaurantById(String id) async {
    final query = await firebaseFirestore.collection(restaurantCollection).doc(id).get();
    return _docMap(query);
   }

  RestaurantModel _docMap(e) => RestaurantModel.fromMap(e.data()).copyWith(id: e.id);
}
