

class ImageCollectionInfo {
  List<String> hotels;
  List<String> restaurants;
  List<String> ecotourism;

  ImageCollectionInfo({
    required this.hotels,
    required this.restaurants,
    required this.ecotourism,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hotels': hotels,
      'restaurants': restaurants,
      'ecotourism': ecotourism,
    };
  }

  factory ImageCollectionInfo.fromMap(Map<String, dynamic> map) {
    return ImageCollectionInfo(
      hotels: List<String>.from(map['hotels']),
      restaurants: List<String>.from(map['restaurants']),
      ecotourism: List<String>.from(map['ecotourism']),
    );
  }
}
