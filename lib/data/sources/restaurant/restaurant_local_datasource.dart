import 'package:conoce_bonao/models/location.dart';
import 'package:conoce_bonao/models/restaurant.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../utils/helper/asset_helper.dart';
import './restaurant_remote_datasource.dart';

class RestaurantLocalDataSource implements IRestaurantDataSource {
  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    final restaurantPhotos = AssetHelper.getAssetsOfType(AssetImageType.restaurantPhotos);
    return [
      RestaurantModel(
        id: "1",
        name: "El Sol",
        title: "Mexicano",
        image: Assets.images.restaurants.restaurant1.path,
        address: "Pedernales",
        description:
            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
        rating: 4.5,
        photos: restaurantPhotos,
        location: LocationModel.unknow(),
      ),
      RestaurantModel(
        id: "2",
        name: "Las Olas",
        title: "Comida marina",
        image: Assets.images.restaurants.restaurant2.path,
        address: "Calle 34, Seralles Kennedy",
        description:
            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
        rating: 3.3,
        photos: restaurantPhotos,
        location: LocationModel.unknow(),
      )
    ];
  }

  @override
  Future<RestaurantModel> getRestaurantById(String id) {
    throw UnimplementedError();
  }
}
