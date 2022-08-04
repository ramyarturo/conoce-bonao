import 'package:conoce_bonao/controllers/user_controller.dart';
import 'package:conoce_bonao/data/repository/user_repository.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/notification_controller.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/hotel_repository.dart';
import '../data/repository/main_repository.dart';
import '../data/repository/province_repository.dart';
import '../data/repository/reservation_repository.dart';
import '../data/repository/resturant_repository.dart';
import '../data/services/notification_service.dart';
import '../data/sources/hotel/hotel_remote_datasource.dart';
import '../data/sources/restaurant/restaurant_remote_datasource.dart';

diInjector() async {
  Get.put(MainRepository());
  Get.put(AuthController());
  Get.put(UserController());
  Get.put(NotificationController());
  Get.put(AuthRepository());
  Get.put(UserRepository());
  Get.put(NotificationService());
  Get.put<IHotelDataSource>(HotelRemoteDataSource());
  Get.put<IRestaurantDataSource>(RestaurantRemoteDataSource());
  Get.put(HotelRepository(remoteDataSource: Get.find()));
  Get.put(RestaurantRepository(remoteDataSource: Get.find()));
  Get.put(ProvinceRepository());
  Get.put(ReservationRepository());
}
