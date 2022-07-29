import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoGalleryViewer extends StatefulWidget {
  const PhotoGalleryViewer({
    super.key,
    required this.images,
    this.initialIndex = 1,
  });
  final List<String> images;
  final int initialIndex;

  @override
  State<PhotoGalleryViewer> createState() => _PhotoGalleryViewerState();
}

class _PhotoGalleryViewerState extends State<PhotoGalleryViewer> {
  late final pageController = PageController(initialPage: widget.initialIndex);

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      pageController: pageController,
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (_, int index) {
        final image = widget.images[index];
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(image),
          initialScale: PhotoViewComputedScale.contained * 0.8,
        );
      },
      itemCount: widget.images.length,
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
