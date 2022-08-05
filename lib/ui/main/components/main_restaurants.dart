import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/ui/restaurant/restaurant_detail_page.dart';
import 'package:conoce_bonao/widgets/shimmer_loading_widget.dart';

import '../../../models/restaurant.dart';
import '../../../widgets/rounded_card_image.dart';
import '../../../widgets/rx_value_listeneable.dart';

class MainRestaurants extends StatelessWidget {
  const MainRestaurants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Resturantes",
          style: Theme.of(context).textTheme.headline6,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 200,
          ),
          child: RxValueListeneableBuilder<List<RestaurantModel>>(
            value: mainController.restaurantList,
            onLoading: const HotelResturantItemLoadingWidget(),
            builder: (context, restaurants) {
              if (restaurants.isEmpty) {
                return const Center(
                  child: Text("No existen restaurantes registrados"),
                );
              }
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: restaurants.length,
                  itemBuilder: (_, index) {
                    final restaurant = restaurants[index];
                    return RestaurantItemCard(
                      restaurant: restaurant,
                      onPressed: () {
                        Get.to(RestaurantDetailPage(restaurant: restaurant));
                      },
                    );
                  });
            },
          ),
        )
      ],
    );
  }
}

class RestaurantItemCard extends StatelessWidget {
  const RestaurantItemCard({
    super.key,
    required this.restaurant,
    this.onPressed,
  });

  final RestaurantModel restaurant;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: restaurant.name,
              child: RoundedCardImage(
                image: restaurant.image,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Text(
              restaurant.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(restaurant.title),
          ],
        ),
      ),
    );
  }
}
