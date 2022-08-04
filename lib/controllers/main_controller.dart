import 'package:conoce_bonao/models/ecotourism.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/repositories.dart';
import 'package:conoce_bonao/core/resource.dart';
import 'package:conoce_bonao/models/hotel.dart';
import 'package:conoce_bonao/models/restaurant.dart';

class MainController extends GetxController {
  final restaurantList = Resource<List<RestaurantModel>>().obs;
  final hotelList = Resource<List<HotelModel>>().obs;
  final carouselList = Resource<List<String>>().obs;
  final ecotourismList = Resource<List<Ecotourism>>().obs;

  @override
  void onReady() {
    super.onReady();
    Future.wait([
      restaurantRepository.getRestaurants(),
      hotelRepository.getHotels(),
      mainRepository.getEcotourismImages(),
      mainRepository.getCarouselImages(),
    ]).then((value) {
      restaurantList.value = value[0] as Resource<List<RestaurantModel>>;
      hotelList.value = value[1] as Resource<List<HotelModel>>;
      ecotourismList.value = value[2] as Resource<List<Ecotourism>>;
      carouselList.value = value[3] as Resource<List<String>>;
    });
  }
}
