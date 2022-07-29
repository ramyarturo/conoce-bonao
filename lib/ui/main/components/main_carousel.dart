import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/widgets/rounded_card_image.dart';
import 'package:conoce_bonao/widgets/rx_value_listeneable.dart';
import 'package:conoce_bonao/widgets/shimmer_loading_widget.dart';

class MainCarousel extends StatelessWidget {
  const MainCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 300,
        maxHeight: 150,
      ),
      child: RxValueListeneableBuilder<List<String>>(
          value: mainController.carouselList,
          onLoading: const _CarouselLoadingShimmer(),
          builder: (_, images) {
            if (images.isEmpty) {
              return const SizedBox.shrink();
            }
            return CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: true,
              ),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                return Padding(
                  padding: const EdgeInsets.all(6),
                  child: RoundedCardImage(
                    image: images[itemIndex],
                    size: const Size.fromHeight(200),
                  ),
                );
              },
            );
          }),
    );
  }
}

class _CarouselLoadingShimmer extends StatelessWidget {
  const _CarouselLoadingShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        for (var index = 0; index < 3; index++)
          const Padding(
            padding: EdgeInsets.only(right: 9),
            child: ContainerLoadingPlaceholder(
              size: Size(175, 100),
            ),
          ),
      ],
    );
  }
}
