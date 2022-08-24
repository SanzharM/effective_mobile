import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_mobile/core/constants/app_colors.dart';
import 'package:effective_mobile/core/constants/app_constraints.dart';
import 'package:effective_mobile/domain/models/best_seller.dart';
import 'package:effective_mobile/ui/screens/app_router.dart';
import 'package:effective_mobile/ui/widgets/custom_shimmer.dart';
import 'package:effective_mobile/ui/widgets/section_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BestSellersBuilder extends StatelessWidget {
  const BestSellersBuilder({Key? key, required this.bestSellers, this.isLoading = false}) : super(key: key);

  final bool isLoading;
  final List<BestSeller> bestSellers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstraints.padding),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Best sellers',
            moreText: 'see more',
          ),
          CustomShimmer(
            isLoading: isLoading,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.65,
                crossAxisCount: 2,
                crossAxisSpacing: AppConstraints.padding,
              ),
              shrinkWrap: true,
              itemCount: isLoading ? 4 : bestSellers.length,
              itemBuilder: (_, i) => ProductCard(
                bestSeller: isLoading ? const BestSeller() : bestSellers[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.bestSeller}) : super(key: key);

  final BestSeller bestSeller;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => AppRouter.toProductDetails(context, 0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: maxWidth,
            margin: const EdgeInsets.symmetric(vertical: AppConstraints.padding),
            padding: const EdgeInsets.all(4.0),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: AppConstraints.borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: CachedNetworkImage(
                      imageUrl: bestSeller.imageUrl ?? '',
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.center,
                      height: maxWidth,
                      errorWidget: (context, url, error) => const Icon(Icons.error_outlined),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '\$${bestSeller.currentPrice?.toString() ?? ''}',
                        style: Theme.of(context).textTheme.bodyLarge?.apply(color: AppColors.darkGrey),
                      ),
                      Text(
                        bestSeller.realPrice?.toString() ?? '',
                        style: Theme.of(context).textTheme.bodySmall?.apply(color: AppColors.grey, decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    bestSeller.title ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 4.0),
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                bestSeller.isFavorites ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                size: 18.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
