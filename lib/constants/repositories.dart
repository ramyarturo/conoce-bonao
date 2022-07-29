import 'package:get/get.dart';
import 'package:conoce_bonao/data/repository/main_repository.dart';

import '../data/repository/auth_repository.dart';
import '../data/repository/hotel_repository.dart';
import '../data/repository/province_repository.dart';
import '../data/repository/reservation_repository.dart';
import '../data/repository/resturant_repository.dart';

MainRepository get mainRepository => Get.find();
AuthRepository get authRepository => Get.find();
HotelRepository get hotelRepository => Get.find();
RestaurantRepository get restaurantRepository => Get.find();
ProvinceRepository get provinceRepository => Get.find();
ReservationRepository get reservationRepository => Get.find();
