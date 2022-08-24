import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/cupertino.dart';

class ProductColorsWidget extends StatelessWidget {
  const ProductColorsWidget({
    Key? key,
    required this.colors,
    required this.onColorPressed,
    this.selectedColor,
    this.itemCount,
  }) : super(key: key);

  final List<Color?>? colors;
  final int? selectedColor;
  final int? itemCount;
  final void Function(int i) onColorPressed;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount ?? colors?.length ?? 0,
      separatorBuilder: (_, sep) => const SizedBox(width: AppConstraints.padding / 2),
      itemBuilder: (_, i) => CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => onColorPressed(i),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors?[i],
            shape: BoxShape.circle,
          ),
          child: selectedColor == i ? const Icon(CupertinoIcons.check_mark, color: AppColors.white, size: 20.0) : null,
          height: 32.0,
          width: 32.0,
        ),
      ),
    );
  }
}
