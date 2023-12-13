import 'package:canteiro_ai/core/colors_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final bool readOnly;
  final bool obscureText;
  final Function(String?)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final TextInputAction? textInputAction;
  final Color? backgroundColor;
  final Color? borderColor;
  final String? suffixText;
  final IconData? suffixIcon;
  final VoidCallback? onTapIcon;
  final VoidCallback? onEditingComplete;
  final Function(String?)? onFieldSubmitted;
  final int? maxLines;
  final double borderRadius;
  final String? initialValue;
  final List<TextInputFormatter>? maskFormatter;

  const InputTextField({
    super.key,
    this.label,
    this.hintText,
    this.readOnly = false,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textInputAction = TextInputAction.next,
    this.backgroundColor,
    this.borderColor,
    this.suffixText,
    this.suffixIcon,
    this.onTapIcon,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.maxLines,
    this.borderRadius = 15,
    this.initialValue,
    this.maskFormatter,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 10),
            child: Text(
              widget.label!,
              style: const TextStyle(fontSize: 14, color: ColorsTheme.primary),
            ),
          ),
        TextFormField(
          inputFormatters: widget.maskFormatter,
          initialValue: widget.initialValue,
          enabled: !widget.readOnly,
          onEditingComplete: widget.onEditingComplete,
          validator: _validator,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          textInputAction: widget.textInputAction,
          obscureText: widget.obscureText,
          style: TextStyle(
            color: ColorsTheme.textGrey,
            fontFamily: 'roboto-regular',
          ),
          decoration: InputDecoration(
            errorText: errorText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            suffixText: widget.suffixText,
            suffixStyle: const TextStyle(
                color: ColorsTheme.primary, fontFamily: 'roboto-bold'),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: widget.suffixIcon != null
                ? GestureDetector(
                    onTap: widget.onTapIcon,
                    child: Icon(widget.suffixIcon),
                  )
                : null,
            suffixIconColor: widget.readOnly
                ? ColorsTheme.textGrey.withOpacity(0.5)
                : ColorsTheme.textGrey,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsTheme.primary,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: widget.borderColor == null
                  ? BorderSide.none
                  : BorderSide(color: widget.borderColor!),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            hintStyle: TextStyle(color: ColorsTheme.hintTextColor),
            hintText: widget.hintText,
            fillColor: widget.backgroundColor ?? ColorsTheme.backgroundField,
          ),
        ),
      ],
    );
  }

  String? _validator(String? s) {
    if (s == null || s.isEmpty) {
      errorText = 'Campo obrigatório';
    } else {
      errorText = null;
    }
    return errorText;
  }
}
