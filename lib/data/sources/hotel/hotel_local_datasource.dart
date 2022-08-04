import 'package:conoce_bonao/data/sources/hotel/hotel_remote_datasource.dart';
import 'package:conoce_bonao/models/hotel.dart';
import 'package:conoce_bonao/models/location.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../utils/helper/asset_helper.dart';

class HotelLocalDataSource implements IHotelDataSource {
  @override
  Future<List<HotelModel>> getHotels() async {
    final hotelPhotos = AssetHelper.getAssetsOfType(AssetImageType.hotelPhotos);
    return [
      HotelModel(
        id: "1",
        name: "Las Arenas",
        image: Assets.images.hotels.hotel1.path,
        address: "Pedernales",
        description:
            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
        temperature: -50,
        visitors: 800,
        rating: 4.4,
        photos: hotelPhotos,
        location: LocationModel.unknow(),
      ),
      HotelModel(
        id: "2",
        name: "Intercontinental",
        image: Assets.images.hotels.hotel2.path,
        address: "Santo domingo Distrito Nacional",
        description:
            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
        temperature: -39,
        visitors: 1439,
        rating: 5.0,
        photos: hotelPhotos,
        location: LocationModel.unknow(),
      )
    ];
  }
  @override
  Future<HotelModel> getHotelById(String id) {
     throw UnimplementedError();
  }
}
