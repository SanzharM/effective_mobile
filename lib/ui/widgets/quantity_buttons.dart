import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuantityButtons extends StatelessWidget {
  const QuantityButtons({
    Key? key,
    required this.onIncrease,
    required this.onDecrease,
    this.quantity = 1,
  }) : super(key: key);

  final void Function() onIncrease;
  final void Function() onDecrease;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: AppConstraints.borderRadius50,
        color: AppColors.grey,
      ),
      child: Column(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onDecrease,
            child: const Icon(CupertinoIcons.minus, color: AppColors.white, size: 12.0),
          ),
          Text(
            '$quantity',
            maxLines: 1,
            style: Theme.of(context).textTheme.labelMedium?.apply(color: AppColors.white),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onIncrease,
            child: const Icon(CupertinoIcons.plus, color: AppColors.white, size: 12.0),
          ),
        ],
      ),
    );
  }
}
