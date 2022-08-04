import 'package:conoce_bonao/core/resource.dart';
import 'package:conoce_bonao/models/restaurant.dart';

import '../sources/restaurant/restaurant_remote_datasource.dart';

class RestaurantRepository {
  IRestaurantDataSource remoteDataSource;
  RestaurantRepository({required this.remoteDataSource});
  Future<Resource<List<RestaurantModel>>> getRestaurants() async {
    return await Resource.fromCallback(() => remoteDataSource.getRestaurants());
  }
  Future<Resource<RestaurantModel>> getRestaurantById(String id) async {
    return await Resource.fromCallback(() => remoteDataSource.getRestaurantById(id));
  }
}
