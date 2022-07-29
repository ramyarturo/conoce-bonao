import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:conoce_bonao/widgets/shimmer_loading_widget.dart';

class RoundedCardImage extends StatelessWidget {
  const RoundedCardImage({
    super.key,
    required this.image,
    this.size = const Size(200, 100),
    this.borderRadius,
    this.elevation = 4,
  });
  final String image;
  final Size size;
  final BorderRadius? borderRadius;
  final double elevation;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(15),
      child: Card(
        elevation: elevation,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            placeholder: (context, url) => ContainerLoadingPlaceholder(size: size),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
