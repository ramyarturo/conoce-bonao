import 'package:carousel_slider/carousel_slider.dart';
import 'package:conoce_bonao/utils/intent_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:conoce_bonao/controllers/map_viewer_controller.dart';
import 'package:conoce_bonao/models/hotel.dart';
import 'package:conoce_bonao/models/restaurant.dart';

import 'components/building_item_card.dart';

class MapViewerPage extends StatefulWidget {
  const MapViewerPage({Key? key}) : super(key: key);

  @override
  State<MapViewerPage> createState() => _MapViewerPageState();
}

class _MapViewerPageState extends State<MapViewerPage> with SingleTickerProviderStateMixin {
  final MapViewerController mapViewerController = Get.put(MapViewerController());
  late Animation<double> opacityAnimation;
  late final AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: 130.milliseconds,
    );
    opacityAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Localización"),
        centerTitle: true,
      ),
      body: GetBuilder<MapViewerController>(
        builder: (_) {
          return Stack(
            children: [
              Listener(
                onPointerDown: (event) {
                  animationController.forward();
                },
                onPointerUp: (event) {
                  animationController.reverse();
                },
                child: GoogleMap(
                  mapType: MapType.normal,
                  buildingsEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: mapViewerController.userCameraPosition,
                  markers: mapViewerController.markers.keys.toSet(),
                  onMapCreated: (GoogleMapController controller) {
                    mapViewerController.googleMapcontroller = controller;
                    if (!mapViewerController.googleMapReadySignal.isCompleted) {
                      mapViewerController.googleMapReadySignal.complete();
                    }
                  },
                ),
              ),
              AnimatedBuilder(
                  animation: animationController,
                  builder: (context, snapshot) {
                    return FadeTransition(
                      opacity: opacityAnimation,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CarouselSlider.builder(
                          carouselController: mapViewerController.carouselController,
                          options: CarouselOptions(
                              aspectRatio: size.height / size.width,
                              onPageChanged: ((index, reason) {
                                mapViewerController.onCarouselIndexChanged(index);
                              })),
                          itemCount: mapViewerController.markers.length,
                          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                            final entries = mapViewerController.markers.entries.toList();
                            if (entries.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            final entry = entries[itemIndex];
                            final isRestaurant = entry.value is RestaurantModel;
                            RestaurantModel? restaurant;
                            HotelModel? hotel;
                            if (isRestaurant) {
                              restaurant = entry.value as RestaurantModel;
                            } else {
                              hotel = entry.value as HotelModel;
                            }

                            return BuildingItemCard(
                                buildingInfo: BuildingInfo(
                                  title: restaurant?.name ?? hotel!.name,
                                  subtitle: restaurant?.title ?? "",
                                  address: restaurant?.address ?? hotel!.address,
                                  image: restaurant?.image ?? hotel!.image,
                                  rating: restaurant?.rating ?? hotel!.rating,
                                  photos: restaurant?.photos ?? hotel!.photos,
                                ),
                                onPressed: () {
                                  mapViewerController.sendCameraTo(entry.key);
                                  IntentUtils.openNavigationMap(latLng: entry.key.position);
                                });
                          },
                        ),
                      ),
                    );
                  })
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
