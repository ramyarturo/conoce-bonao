import 'package:conoce_bonao/models/ecotourism.dart';
import 'package:get/get.dart';

import 'package:conoce_bonao/constants/firebase.dart';
import 'package:conoce_bonao/core/resource.dart';
import 'package:synchronized/synchronized.dart';

import '../../models/image_collection.dart';

class MainRepository {
  final lock = Lock();
  Future<Resource<List<String>>> getCarouselImages() {
    return Resource.fromCallback(() async {
      final images = await _getImages();
      return images.hotels + images.restaurants;
    });
  }
 
 Future<Resource<List<Ecotourism>>> getEcotourismImages() {
    return Resource.fromCallback(() async {
      final queryDocuments = await firebaseFirestore.collection(ecotourismCollection).get();
      final result = queryDocuments.docs.map((e) => e.data());
      return result.map((e) => Ecotourism.fromMap(e)).toList();
    });
  }


  Future<ImageCollectionInfo> _getImages() {
    return lock.synchronized(() async {
      final queryDocuments = await firebaseFirestore.collection(imagesCollection).get();
      final result = queryDocuments.docs.map((e) => e.data());

      final mergedMaps = result.expand((element) => element.entries);
      return ImageCollectionInfo.fromMap(Map.fromEntries(mergedMaps));
    });
  }
}
