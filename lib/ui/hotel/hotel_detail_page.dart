import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/models/hotel.dart';
import 'package:conoce_bonao/ui/auth/login/login_page.dart';
import 'package:conoce_bonao/ui/hotel/components/hotel_description.dart';
import 'package:conoce_bonao/widgets/buttons/custom_button.dart';

import '../../constants/theme.dart';
import '../reservation/reservation_page.dart';
import 'components/hotel_image.dart';
import 'components/hotel_info.dart';
import 'components/hotel_photos.dart';

class HotelDetailPage extends StatefulWidget {
  HotelDetailPage({super.key, required this.hotel});
  final HotelModel hotel;

  @override
  State<HotelDetailPage> createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HotelImage(hotel: widget.hotel),
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
                          HotelDescription(hotel: widget.hotel),
                          const SizedBox(height: 15),
                          HotelInfo(hotel: widget.hotel),
                          const SizedBox(height: 15),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 100,
                            ),
                            child: HotelPhotos(hotel: widget.hotel),
                          ),
                          const VerticalSpacing(),
                          SizedBox(
                            width: 300,
                            child: CustomButton(
                              text: "Reservar",
                              icon: Icons.arrow_forward,
                              secundary: true,
                              onPressed: () {
                                if (authController.isLoggedIn) {
                                  Get.to(ReservationPage(
                                    reservationType: ReservationType.hotel,
                                    hotel: widget.hotel,
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
