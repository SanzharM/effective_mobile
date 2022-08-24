import 'package:effective_mobile/core/constants/app_colors.dart';
import 'package:effective_mobile/core/constants/app_constraints.dart';
import 'package:effective_mobile/domain/models/item_category.dart';
import 'package:effective_mobile/ui/widgets/custom_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryBuilder extends StatelessWidget {
  const CategoryBuilder({
    Key? key,
    required this.categories,
    this.isLoading = false,
    required this.onCategoryPressed,
    this.selectedIndex,
  }) : super(key: key);

  final List<ItemCategory> categories;
  final bool isLoading;
  final int? selectedIndex;
  final void Function(int) onCategoryPressed;

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      isLoading: isLoading,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppConstraints.padding),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) => isLoading
            ? const CategoryItemWidget(category: ItemCategory())
            : CupertinoButton(
                padding: EdgeInsets.zero,
                pressedOpacity: 0.75,
                onPressed: () => onCategoryPressed(i),
                child: CategoryItemWidget(
                  isSelected: selectedIndex == i,
                  category: categories[i],
                ),
              ),
        separatorBuilder: (_, sep) => const SizedBox(width: AppConstraints.padding / 2),
        itemCount: isLoading ? 5 : categories.length,
      ),
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({Key? key, required this.category, this.isSelected = false}) : super(key: key);

  final ItemCategory category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppConstraints.padding),
          margin: const EdgeInsets.only(bottom: AppConstraints.padding / 2),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            category.icon ?? '',
            fit: BoxFit.cover,
            height: 36.0,
            color: isSelected ? AppColors.white : AppColors.primary,
            errorBuilder: (_, error, stackTrace) => Icon(
              Icons.error_outline_outlined,
              color: isSelected ? AppColors.white : AppColors.lightGrey,
              size: 36.0,
            ),
          ),
        ),
        if (category.title?.isNotEmpty ?? false)
          Text(
            category.title!,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyMedium?.apply(color: isSelected ? AppColors.primary : null),
          ),
      ],
    );
  }
}
