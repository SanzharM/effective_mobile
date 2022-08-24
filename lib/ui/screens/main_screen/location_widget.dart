import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key, required this.address, required this.onFilterPressed}) : super(key: key);

  final String? address;
  final void Function() onFilterPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined, size: 18.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  address?.toString() ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_outlined, size: 18.0, color: AppColors.grey),
            ],
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: onFilterPressed,
          icon: Image.asset(AppIcons.filter, height: 12.0),
        ),
      ],
    );
  }
}
