import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/models/restaurant.dart';
import 'package:conoce_bonao/ui/auth/login/login_page.dart';
import 'package:conoce_bonao/ui/reservation/reservation_page.dart';
import 'package:conoce_bonao/ui/restaurant/components/restaurant_description.dart';
import 'package:conoce_bonao/ui/restaurant/components/restaurant_image.dart';
import 'package:conoce_bonao/ui/restaurant/components/restaurant_photos.dart';
import 'package:conoce_bonao/widgets/buttons/custom_button.dart';

import '../../constants/theme.dart';

class RestaurantDetailPage extends StatefulWidget {
  RestaurantDetailPage({super.key, required this.restaurant});
  final RestaurantModel restaurant;

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            RestaurantImage(restaurant: widget.restaurant),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1.0),
                  duration: const Duration(milliseconds: 900),
                  builder: (context, value, _) {
                    final transform = Curves.elasticOut.transform(value);
                    return Transform(
                      transform: Matrix4.identity().scaled(1.0, transform),
                      child: Column(
                        children: [
                          RestaurantDescription(restaurant: widget.restaurant),
                          const SizedBox(height: 15),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 100,
                            ),
                            child: RestaurantPhotos(restaurant: widget.restaurant),
                          ),
                          const VerticalSpacing(),
                          SizedBox(
                            width: 300,
                            child: CustomButton(
                              text: "Reservar una Mesa",
                              icon: Icons.table_bar,
                              secundary: true,
                              onPressed: () {
                                if (authController.isLoggedIn) {
                                  Get.to(ReservationPage(
                                    reservationType: ReservationType.restaurant,
                                    restaurant: widget.restaurant,
                                  ));
                                } else {
                                  Get.to(() => const LoginPage());
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
