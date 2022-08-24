import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/cupertino.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.padding,
    this.color,
    this.pressedOpacity,
  }) : super(key: key);

  final EdgeInsets? padding;
  final void Function() onPressed;
  final Widget icon;
  final Color? color;
  final double? pressedOpacity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstraints.padding / 2),
      child: CupertinoButton(
        pressedOpacity: pressedOpacity ?? 0.6,
        padding: padding ?? EdgeInsets.zero,
        onPressed: onPressed,
        child: icon,
        color: color ?? AppColors.darkGrey,
      ),
    );
  }
}
