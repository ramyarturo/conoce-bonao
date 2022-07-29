import 'package:conoce_bonao/models/hotel.dart';

import '../../../../constants/firebase.dart';

abstract class IHotelDataSource {
  Future<List<HotelModel>> getHotels();
}

class HotelRemoteDataSource implements IHotelDataSource {
  @override
  Future<List<HotelModel>> getHotels() async {
    final queryDocuments = await firebaseFirestore.collection(hotelCollection).get();
    final hotels = queryDocuments.docs.map(_docsMap).toList();
    return hotels.toList();
  }

  HotelModel _docsMap(e) => HotelModel.fromMap(e.data()).copyWith(id: e.id);
}
