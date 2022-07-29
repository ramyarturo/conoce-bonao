import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/core/resource.dart';
import 'package:conoce_bonao/gen/assets.gen.dart';
import 'package:conoce_bonao/models/restaurant.dart';
import 'package:conoce_bonao/utils/dialog_utils.dart';
import 'package:conoce_bonao/utils/helper/location_helper.dart';
import 'package:conoce_bonao/widgets/loading_widget.dart';
import 'package:location/location.dart';

import '../core/exceptions.dart';
import '../models/hotel.dart';

class MapViewerController extends GetxController {
  late BitmapDescriptor restaurantBitmapDescriptor;
  late BitmapDescriptor hotelBitmapDescriptor;
  LocationData? userLocation;
  late GoogleMapController googleMapcontroller;
  final Completer googleMapReadySignal = Completer();
  final CarouselController carouselController = CarouselController();
  final markers = <Marker, dynamic>{};
  final List<StreamSubscription> _subscriptions = [];
  @override
  void onReady() async {
    super.onReady();
    _loadBitmapIcons();
    await _requestUserLocation();
    await googleMapReadySignal.future;
    googleMapcontroller.animateCamera(CameraUpdate.newCameraPosition(userCameraPosition));

    _startListeners();
  }

  _startListeners() {
    final restaurantObserver = mainController.restaurantList.listenAndPump((event) {
      _loadRestaurantMarkers(event.data ?? []);
    });
    final hotelObserver = mainController.hotelList.listenAndPump((event) {
      _loadHotelMarkers(event.data ?? []);
    });
    _subscriptions.addAll([restaurantObserver, hotelObserver]);
  }

  _loadRestaurantMarkers(List<RestaurantModel> restaurants) async {
    for (var restaurant in restaurants) {
      final marker = Marker(
        markerId: MarkerId(restaurant.name),
        icon: restaurantBitmapDescriptor,
        position: restaurant.location.toLatLng(),
        onTap: () {
          final index = markers.values.toList().indexOf(restaurant);
          carouselController.animateToPage(index);
        },
      );
      markers[marker] = restaurant;
    }
    refresh();
  }

  _loadHotelMarkers(List<HotelModel> hotels) async {
    for (var hotel in hotels) {
      final marker = Marker(
          markerId: MarkerId(hotel.name),
          icon: hotelBitmapDescriptor,
          position: hotel.location.toLatLng(),
          onTap: () {
            final index = markers.values.toList().indexOf(hotel);
            carouselController.animateToPage(index);
          });
      markers[marker] = hotel;
    }

    refresh();
  }

  sendCameraTo(Marker marker) async {
    googleMapcontroller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: marker.position,
      zoom: 17,
    )));
  }

  onCarouselIndexChanged(int index) async {
    final Marker marker = markers.keys.toList()[index];
    sendCameraTo(marker);
  }

  _requestUserLocation() async {
    showLoading();

    final result = await Resource.fromCallback(
      () => LocationHelper.getLocation(),
      errorParser: _parseRequestLocationException,
    );
    hideLoading();
    if (result.isSuccessful) {
      userLocation = result.data!;
      return;
    }
    await DialogUtils.showOkDialog(message: result.getErrorOr());
  }

  String? _parseRequestLocationException(exception) {
    if (exception is DeniedLocationPermissionExcetion) {
      return "Permiso denegado";
    }
    if (exception is RequestLocationServiceException) {
      return "Servicio de localización deshabilitado, no se podrá visualizar los hoteles y restaurantes cerca de usted";
    }
    return null;
  }

  CameraPosition get userCameraPosition => CameraPosition(
        target: LatLng(userLocation?.latitude ?? 0.0, userLocation?.longitude ?? 0.0),
        zoom: 16,
      );
  _loadBitmapIcons() async {
    hotelBitmapDescriptor = await _getBitmapDescriptor(Assets.icons.hotelMarker.path);
    restaurantBitmapDescriptor = await _getBitmapDescriptor(Assets.icons.restaurantMarker.path);
  }

  Future<BitmapDescriptor> _getBitmapDescriptor(String assetImage) {
    return BitmapDescriptor.fromAssetImage(
      createLocalImageConfiguration(Get.context!),
      assetImage,
    );
  }

  @override
  void onClose() {
    super.onClose();
    googleMapcontroller.dispose();

    for (var element in _subscriptions) {
      element.cancel();
    }
  }
}
