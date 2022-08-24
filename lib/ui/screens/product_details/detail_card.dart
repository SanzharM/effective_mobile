import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({
    Key? key,
    required this.children,
    this.headerTitle,
    this.headerActions,
  }) : super(key: key);

  final List<Widget> children;
  final String? headerTitle;
  final List<Widget>? headerActions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstraints.padding,
        horizontal: AppConstraints.padding,
      ),
      decoration: const BoxDecoration(
        borderRadius: AppConstraints.borderRadiusTLR,
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (headerTitle?.isNotEmpty ?? false)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    headerTitle!,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (headerActions?.isNotEmpty ?? false) ...headerActions!,
              ],
            ),
          ...children,
        ],
      ),
    );
  }
}
