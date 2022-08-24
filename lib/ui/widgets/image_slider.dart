import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    Key? key,
    required this.imageUrls,
    this.itemCount,
    this.enableInfiniteScroll = true,
    this.enlargeCenterPage = true,
    this.disableCenter = true,
    this.imageFit,
    this.errorWidget,
  }) : super(key: key);

  final List<String?> imageUrls;
  final int? itemCount;
  final bool enableInfiniteScroll;
  final bool enlargeCenterPage;
  final bool disableCenter;
  final BoxFit? imageFit;
  final Widget Function(BuildContext context, String url, dynamic error)? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        enableInfiniteScroll: enableInfiniteScroll,
        enlargeCenterPage: enlargeCenterPage,
        disableCenter: disableCenter,
      ),
      itemCount: itemCount ?? imageUrls.length,
      itemBuilder: (_, i, realIndex) => Container(
        padding: const EdgeInsets.all(AppConstraints.padding / 2),
        margin: const EdgeInsets.symmetric(vertical: AppConstraints.padding / 2),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppConstraints.borderRadius,
          boxShadow: [
            BoxShadow(
              color: AppColors.darkGrey.withOpacity(0.1),
              blurRadius: 5.0,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrls[i] ?? '',
          height: double.maxFinite,
          width: double.maxFinite,
          fit: imageFit,
          errorWidget: errorWidget,
        ),
      ),
    );
  }
}
