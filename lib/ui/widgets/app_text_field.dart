import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? key,
    required this.text,
    this.label,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.needValidator = true,
    this.readonly = false,
    this.hintText,
    this.hintStyle,
    this.inputType = TextInputType.text,
    this.maxLength,
    this.maxLines,
    this.prefix,
    this.prefixIcon,
  }) : super(key: key);

  final String? text;
  final String? label;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final bool needValidator;
  final bool readonly;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputType inputType;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefix;
  final Widget? prefixIcon;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete ?? () => FocusScope.of(context).nextFocus(),
      keyboardType: widget.inputType,
      maxLength: widget.maxLength ?? 300,
      maxLines: widget.maxLines,
      readOnly: widget.readonly,
      validator: widget.needValidator ? _textValidator : null,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(decoration: TextDecoration.none),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.apply(color: AppColors.grey),
        border: InputBorder.none,
        focusColor: AppColors.white,
        focusedErrorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        counterText: '',
        errorBorder: InputBorder.none,
        prefix: widget.prefix,
        prefixIcon: widget.prefixIcon,
      ),
    );
  }

  String? _textValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Field cannot be empty';
    }
    return null;
  }
}
