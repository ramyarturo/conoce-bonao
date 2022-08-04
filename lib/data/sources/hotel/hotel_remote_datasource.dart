import 'package:conoce_bonao/models/hotel.dart';

import '../../../../constants/firebase.dart';

abstract class IHotelDataSource {
  Future<List<HotelModel>> getHotels();
  Future<HotelModel> getHotelById(String id);
}

class HotelRemoteDataSource implements IHotelDataSource {
  @override
  Future<List<HotelModel>> getHotels() async {
    final queryDocuments = await firebaseFirestore.collection(hotelCollection).get();
    final hotels = queryDocuments.docs.map(_docsMap).toList();
    return hotels.toList();
  }

  @override
  Future<HotelModel> getHotelById(String id) async {
    final query = await firebaseFirestore.collection(hotelCollection).doc(id).get();
    return _docsMap(query);
  }

  HotelModel _docsMap(e) => HotelModel.fromMap(e.data()).copyWith(id: e.id);
}
