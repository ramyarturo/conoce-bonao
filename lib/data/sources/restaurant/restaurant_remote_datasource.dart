import 'package:conoce_bonao/constants/firebase.dart';
import 'package:conoce_bonao/models/restaurant.dart';

abstract class IRestaurantDataSource {
  Future<List<RestaurantModel>> getRestaurants();
}

class RestaurantRemoteDataSource implements IRestaurantDataSource {
  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    final queryDocuments = await firebaseFirestore.collection(restaurantCollection).get();
    final restaurants = queryDocuments.docs.map(_docsMap).toList();
    return restaurants.toList();
  }

  RestaurantModel _docsMap(e) => RestaurantModel.fromMap(e.data()).copyWith(id: e.id);
}
