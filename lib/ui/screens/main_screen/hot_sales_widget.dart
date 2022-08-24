import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_mobile/core/constants/constants.dart';
import 'package:effective_mobile/domain/models/hot_sale.dart';
import 'package:effective_mobile/ui/widgets/section_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HotSalesWidget extends StatelessWidget {
  const HotSalesWidget({Key? key, required this.items, this.isLoading = false}) : super(key: key);

  final List<HotSale> items;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstraints.padding),
          child: SectionTitle(
            title: 'Hot sales',
            moreText: 'see more',
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: AppConstraints.padding),
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            itemBuilder: (_, i) => HotSaleBanner(item: isLoading ? const HotSale() : items[i]),
            separatorBuilder: (_, sep) => const SizedBox(width: AppConstraints.padding * 2),
            itemCount: isLoading ? 3 : items.length,
          ),
        ),
      ],
    );
  }
}

class HotSaleBanner extends StatelessWidget {
  const HotSaleBanner({Key? key, required this.item}) : super(key: key);

  final HotSale item;

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - (AppConstraints.padding * 2);
    return ClipRRect(
      borderRadius: AppConstraints.borderRadius,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: item.imageUrl ?? '',
            alignment: Alignment.center,
            width: cardWidth,
            height: double.maxFinite,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Container(
              width: cardWidth,
              height: double.maxFinite,
              decoration: const BoxDecoration(color: AppColors.white),
              child: const Icon(Icons.error),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: cardWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstraints.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (item.isNew)
                          Container(
                            padding: const EdgeInsets.all(AppConstraints.padding / 2),
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
                            child: const Text(
                              'New',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.white),
                            ),
                          ),
                        Text(
                          item.title ?? '',
                          style: Theme.of(context).textTheme.titleLarge?.apply(color: AppColors.white),
                        ),
                        Text(
                          item.subtitle ?? '',
                          style: const TextStyle(fontSize: 11, color: AppColors.white),
                        ),
                        CupertinoButton(
                          color: AppColors.lightGrey,
                          padding: const EdgeInsets.symmetric(horizontal: AppConstraints.padding * 2),
                          alignment: Alignment.center,
                          child: const Text(
                            'Buy now!',
                            style: TextStyle(fontSize: 11, color: AppColors.darkGrey, fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
