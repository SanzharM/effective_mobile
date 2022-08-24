import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    this.title,
    required this.values,
    required this.currentValue,
    required this.onChanged,
  }) : super(key: key);

  final String? title;
  final List<T> values;
  final T currentValue;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title?.isNotEmpty ?? false)
          Text(
            title!,
            style: Theme.of(context).textTheme.bodyLarge?.apply(color: AppColors.darkGrey),
          ),
        Container(
          padding: const EdgeInsets.only(left: AppConstraints.padding / 2),
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGrey),
            borderRadius: AppConstraints.borderRadius,
          ),
          child: DropdownButton<T>(
            underline: const SizedBox(),
            value: currentValue,
            enableFeedback: true,
            borderRadius: AppConstraints.borderRadius,
            items: values
                .map((e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ))
                .toList(),
            dropdownColor: AppColors.white,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
