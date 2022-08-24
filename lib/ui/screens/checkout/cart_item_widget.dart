import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_mobile/core/constants/app_colors.dart';
import 'package:effective_mobile/core/constants/app_constraints.dart';
import 'package:effective_mobile/core/supporting/utils.dart';
import 'package:effective_mobile/domain/models/cart_item.dart';
import 'package:effective_mobile/ui/widgets/quantity_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.onDecrease,
    required this.onIncrease,
    required this.onDelete,
  }) : super(key: key);

  final CartItem? cartItem;
  final void Function() onIncrease;
  final void Function() onDecrease;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          child: ClipRRect(
            borderRadius: AppConstraints.borderRadius,
            child: CachedNetworkImage(
              imageUrl: cartItem?.image ?? '',
              placeholder: (_, url) => const SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator.adaptive(),
              ),
              errorWidget: (_, url, error) => Container(
                padding: const EdgeInsets.all(AppConstraints.padding),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppConstraints.borderRadius,
                ),
                child: const Icon(Icons.error, color: AppColors.primary),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem?.title ?? '',
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyLarge?.apply(color: AppColors.white),
              ),
              Text(
                Utils.toFormattedPrice(cartItem?.price),
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyLarge?.apply(color: AppColors.primary),
              ),
            ],
          ),
        ),
        QuantityButtons(
          quantity: cartItem?.quantity ?? 1,
          onIncrease: onIncrease,
          onDecrease: onDecrease,
        ),
        CupertinoButton(
          child: const Icon(CupertinoIcons.delete, color: AppColors.spaceGrey),
          onPressed: onDelete,
        ),
      ],
    );
  }
}
