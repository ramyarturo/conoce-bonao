import 'dart:convert';

import 'package:flutter/services.dart';

enum AssetImageType {
  carousel("carousel"),
  ecotourism("ecotourism"),
  hotel("hotels"),
  hotelPhotos("hotels/photos"),
  restaurants("restaurants"),
  restaurantPhotos("restaurants/photos");

  const AssetImageType(this.path);
  final String path;
}

abstract class AssetHelper {
  static late final Map<String, dynamic> _assetsMap;
  static late final List<String> _assetsImage;
  static List<String> _getAssetsImage() {
    return _assetsMap.keys.where((element) => element.contains("assets/images")).toList();
  }

  static List<String> getAssetsOfType(AssetImageType assetType) {
    return _assetsImage.where((element) {
      return element.contains("/images/${assetType.path}/");
    }).toList();
  }

  static _load() async {
    final content = await rootBundle.loadString('AssetManifest.json');
    _assetsMap = json.decode(content) as Map<String, dynamic>;
  }

  static loadAssets() async {
    await _load();
    _assetsImage = _getAssetsImage();
  }
}
