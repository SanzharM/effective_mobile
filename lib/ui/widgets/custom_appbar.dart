import 'package:effective_mobile/core/constants/constants.dart';
import 'package:effective_mobile/ui/widgets/app_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.centerTitle = false,
    this.leading,
    this.automaticallyImplyLeading = false,
    this.actions,
    this.overlayStyle,
  }) : super(key: key);

  final String? title;
  final bool centerTitle;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final SystemUiOverlayStyle? overlayStyle;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: (title?.isNotEmpty ?? false)
          ? Text(
              title!,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          : null,
      centerTitle: centerTitle,
      leading: leading ??
          AppIconButton(
            icon: const Icon(CupertinoIcons.left_chevron, color: AppColors.white, size: 18.0),
            onPressed: () => Navigator.of(context).pop(),
          ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      systemOverlayStyle: overlayStyle ?? SystemUiOverlayStyle.dark,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
