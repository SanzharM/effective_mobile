import 'package:effective_mobile/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({Key? key, required this.child, this.isLoading = false}) : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isLoading
          ? Shimmer.fromColors(
              child: child,
              baseColor: AppColors.white,
              highlightColor: AppColors.lightGrey,
            )
          : child,
    );
  }
}
