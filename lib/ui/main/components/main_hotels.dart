import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/widgets/rounded_card_image.dart';
import 'package:conoce_bonao/widgets/rx_value_listeneable.dart';
import 'package:conoce_bonao/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/hotel.dart';
import '../../../widgets/rating_widget.dart';
import '../../hotel/hotel_detail_page.dart';

class MainHotels extends StatelessWidget {
  const MainHotels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hoteles y Villas",
          style: Theme.of(context).textTheme.headline6,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 200,
          ),
          child: RxValueListeneableBuilder<List<HotelModel>>(
            value: mainController.hotelList,
            onLoading: const HotelResturantItemLoadingWidget(),
            builder: (context, hotels) {
              if (hotels.isEmpty) {
                return const Center(child: Text("No existen hoteles registrados"));
              }
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: hotels.length,
                  itemBuilder: ((_, index) {
                    final hotel = hotels[index];
                    return HotelItemCard(
                      hotel: hotel,
                      onPressed: () {
                        final route = MaterialPageRoute(builder: (context) {
                          return HotelDetailPage(hotel: hotel);
                        });
                        Navigator.of(context).push(route);
                      },
                    );
                  }));
            },
          ),
        )
      ],
    );
  }
}

class HotelItemCard extends StatelessWidget {
  const HotelItemCard({
    super.key,
    required this.hotel,
    this.onPressed,
  });

  final HotelModel hotel;
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
                tag: hotel.name,
                child: RoundedCardImage(
                  image: hotel.image,
                  borderRadius: BorderRadius.circular(25),
                )),
            Text(
              hotel.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            RatingWidget(
              rating: hotel.rating,
            ),
          ],
        ),
      ),
    );
  }
}
