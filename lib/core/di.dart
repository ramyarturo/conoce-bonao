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
  put<T>(T dependency) => Get.put<T>(dependency, permanent: true);
  put(MainRepository());
  put(AuthController());
  put(UserController());
  put(NotificationController());
  put(AuthRepository());
  put(UserRepository());
  put(NotificationService());
  put<IHotelDataSource>(HotelRemoteDataSource());
  put<IRestaurantDataSource>(RestaurantRemoteDataSource());
  put(HotelRepository(remoteDataSource: Get.find()));
  put(RestaurantRepository(remoteDataSource: Get.find()));
  put(ProvinceRepository());
  put(ReservationRepository());
}
