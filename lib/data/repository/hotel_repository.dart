import 'package:conoce_bonao/core/resource.dart';
import 'package:conoce_bonao/data/sources/hotel/hotel_remote_datasource.dart';
import 'package:conoce_bonao/models/hotel.dart';

class HotelRepository {
  IHotelDataSource remoteDataSource;
  HotelRepository({required this.remoteDataSource});
  Future<Resource<List<HotelModel>>> getHotels() async {
    return await Resource.fromCallback(() => remoteDataSource.getHotels());
  }

  Future<Resource<HotelModel>> getHotelById(String id) async {
    return await Resource.fromCallback(() => remoteDataSource.getHotelById(id));
  }
}
