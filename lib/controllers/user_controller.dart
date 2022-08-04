import 'package:conoce_bonao/constants/repositories.dart';
import 'package:conoce_bonao/core/resource.dart';
import 'package:conoce_bonao/models/reservation.dart';
import 'package:conoce_bonao/utils/dialog_utils.dart';
import 'package:get/get.dart';

import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/constants/firebase.dart';
import 'package:conoce_bonao/models/hotel.dart';
import 'package:conoce_bonao/models/restaurant.dart';
import 'package:rxdart/rxdart.dart' hide Rx;

import '../models/user.dart';

class UserReservation {
  late Map<ReservationRequest, HotelModel> hotels;
  late Map<ReservationRequest, RestaurantModel> restaurants;
  UserReservation({
    required this.hotels,
    required this.restaurants,
  });
  UserReservation.empty() {
    hotels = {};
    restaurants = {};
  }
  int get totalReservations => hotels.length + restaurants.length;
}

class UserController extends GetxController {
  final currentUser = Rx<UserModel?>(null);
  final userReservations = Resource(UserReservation.empty()).obs;
  @override
  onReady() {
    super.onReady();
    userReservations.bindStream(listenCurrentUserReservations());
  }

  updateUser(UserModel user) {
    return userRepository.updateUser(user);
  }

  updateUserBalance(double value) async {
    await Future.delayed(1.seconds);
    await updateUser(currentUser.value!.copyWith(
      balance: currentUser.value!.balance + value,
    ));
  }

  updateUserReservation(ReservationRequest request) async {
    request.state = "Cancelado";
    DialogUtils.showLoadingDialog(message: "Cancelando Reservación...");
    await reservationRepository.updateReservation(request);
    DialogUtils.hideLoadingDialog();
  }

  Stream<Resource<UserReservation>> listenCurrentUserReservations() async* {
 
    yield* authController.firebaseUser.stream.where((user) => user != null).switchMap((user) {
      return firebaseFirestore
          .collection(reservationCollection)
          .where("userId", isEqualTo: user!.uid)
          .snapshots()
          .map((event) => event.docs)
          .asyncMap((event) async {
        final userReservation = UserReservation.empty();
        for (var element in event) {
          final data = ReservationRequest.fromMap(element.data())..id = element.id;
          final hotelReservationDetail = data.hotelReservationDetail;
          final restaurantReservationDetail = data.restaurantReservationDetail;

          if (hotelReservationDetail != null) {
            final hotel = await hotelRepository.getHotelById(hotelReservationDetail.hotelId);
            userReservation.hotels[data] = hotel.data!;
          } else {
            final restaurant = await restaurantRepository.getRestaurantById(
              restaurantReservationDetail!.restaurantId,
            );
            userReservation.restaurants[data] = restaurant.data!;
          }
        }
        return Resource.success(userReservation);
      });
    });
  }
}
