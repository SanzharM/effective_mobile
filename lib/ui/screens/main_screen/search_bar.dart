import 'package:effective_mobile/core/constants/app_colors.dart';
import 'package:effective_mobile/core/constants/app_constraints.dart';
import 'package:effective_mobile/ui/widgets/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String _searchingText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstraints.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: AppConstraints.borderRadius50,
                color: AppColors.white,
              ),
              child: AppTextField(
                text: _searchingText,
                hintText: 'Search',
                maxLines: 1,
                maxLength: 100,
                prefixIcon: const Icon(CupertinoIcons.search, color: AppColors.primary),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: AppConstraints.padding / 1.5),
            padding: const EdgeInsets.all(AppConstraints.padding / 1.5),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(CupertinoIcons.qrcode, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
