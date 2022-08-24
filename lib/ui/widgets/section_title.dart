import 'package:effective_mobile/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.maxLines = 1,
    this.titleColor,
    this.moreColor,
    this.moreText,
    this.onMorePressed,
  }) : super(key: key);

  final String title;
  final String? moreText;
  final void Function()? onMorePressed;
  final Color? titleColor;
  final Color? moreColor;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: Text(
            title,
            maxLines: maxLines,
            style: Theme.of(context).textTheme.headlineSmall?.apply(color: titleColor ?? AppColors.darkGrey),
          ),
        ),
        Flexible(
          flex: 1,
          child: TextButton(
            onPressed: onMorePressed,
            child: Text(
              'view all',
              maxLines: maxLines,
              style: Theme.of(context).textTheme.bodyMedium?.apply(color: moreColor ?? AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
