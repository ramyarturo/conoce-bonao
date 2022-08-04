import 'package:conoce_bonao/constants/firebase.dart';
import 'package:conoce_bonao/core/resource.dart';
import 'package:conoce_bonao/models/reservation.dart';

class ReservationRepository {
  Future<Resource> createReservation(ReservationRequest request) async {
    return Resource.fromCallback(() {
      return firebaseFirestore.collection(reservationCollection).add(request.toMap());
    });
  }

  Future<Resource> updateReservation(ReservationRequest request) async {
    return Resource.fromCallback(() {
      return firebaseFirestore.collection(reservationCollection).doc(request.id).set(
            request.toMap(),
          );
    });
  }
}
