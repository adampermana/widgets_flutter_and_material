import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.initialValue,
    this.requiredMarking = false,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.onsubmit,
    this.suffixIcon,
    this.manualError = false,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? initialValue;
  final bool requiredMarking;
  final bool obscureText;
  final bool readOnly;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool manualError;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onsubmit;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text.rich(TextSpan(
            text: labelText,
            children: !requiredMarking
                ? null
                : [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
          )),
          const SizedBox(height: 5.0),
        ],
        TextFormField(
          key: key,
          controller: controller,
          initialValue: initialValue,
          obscureText: obscureText,
          readOnly: readOnly,
          onFieldSubmitted: onsubmit,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          style: DefaultTextStyle.of(context).style,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(16, 16, 26, 0.063),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black54),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: !manualError
                ? OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8))
                : theme.inputDecorationTheme.border?.copyWith(
                    borderSide: BorderSide(color: theme.colorScheme.error),
                  ),
            enabledBorder: !manualError
                ? OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8))
                : theme.inputDecorationTheme.enabledBorder?.copyWith(
                    borderSide: BorderSide(color: theme.colorScheme.error),
                  ),
            focusedBorder: !manualError
                ? null
                : theme.inputDecorationTheme.focusedBorder?.copyWith(
                    borderSide: BorderSide(
                      color: theme.colorScheme.error,
                      width: 2.0,
                    ),
                  ),
            suffixIconConstraints: suffixIcon != null && suffixIcon is Text
                ? const BoxConstraints(minWidth: 16.0)
                : const BoxConstraints(
                    minWidth: 32.0,
                    minHeight: 24.0,
                  ),
          ),
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
        )
      ],
    );
  }
}
