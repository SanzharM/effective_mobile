import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';

class TitledIcon extends StatelessWidget {
  const TitledIcon({Key? key, required this.asset, required this.value}) : super(key: key);

  final String asset;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(asset, height: 24.0),
        Padding(
          padding: const EdgeInsets.only(top: AppConstraints.padding / 2),
          child: Text(
            value,
            maxLines: 2,
            style: Theme.of(context).textTheme.labelSmall?.apply(color: AppColors.grey).copyWith(letterSpacing: 0),
          ),
        ),
      ],
    );
  }
}
