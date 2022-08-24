import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CheckoutCell extends StatelessWidget {
  const CheckoutCell({Key? key, this.leftText, this.rightText}) : super(key: key);

  final String? leftText;
  final String? rightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstraints.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.apply(color: AppColors.white),
          ),
          Text(
            rightText ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.apply(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
