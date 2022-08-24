import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCapacitiesWidget extends StatelessWidget {
  const ProductCapacitiesWidget({
    Key? key,
    required this.capacity,
    required this.onCapacityPressed,
    this.selectedCapacity,
    this.itemCount,
  }) : super(key: key);

  final List<String?>? capacity;
  final void Function(int i) onCapacityPressed;
  final int? selectedCapacity;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: capacity?.length ?? 0,
      separatorBuilder: (_, sep) => const SizedBox(width: 8.0),
      itemBuilder: (_, i) => CupertinoButton(
        color: selectedCapacity == i ? AppColors.primary : null,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstraints.padding,
          vertical: AppConstraints.padding / 2,
        ),
        onPressed: () => onCapacityPressed(i),
        child: Text(
          '${capacity?[i] ?? ''} GB',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
