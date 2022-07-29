import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  final Widget placeholder;

  const ShimmerLoadingWidget({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: placeholder,
    );
  }
}

class ContainerLoadingPlaceholder extends StatelessWidget {
  final Size size;

  const ContainerLoadingPlaceholder({super.key, required this.size});
  @override
  Widget build(BuildContext context) {
    return ShimmerLoadingWidget(
        placeholder: Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
    ));
  }
}

class HotelRestaurantItemPlaceHolder extends StatelessWidget {
  const HotelRestaurantItemPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          height: 100,
          color: Colors.white,
        ),
        const SizedBox(height: 8.0),
        Container(
          width: 70,
          height: 23.0,
          color: Colors.white,
        ),
        const SizedBox(height: 8.0),
        Container(
          width: 72,
          height: 10.0,
          color: Colors.white,
        ),
      ],
    );
  }
}

class HotelResturantItemLoadingWidget extends StatelessWidget {
  const HotelResturantItemLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.filled(
        4,
        const Padding(
          padding: EdgeInsets.only(
            right: 7.0,
          ),
          child: ShimmerLoadingWidget(placeholder: HotelRestaurantItemPlaceHolder()),
        ),
      ),
    );
  }
}
