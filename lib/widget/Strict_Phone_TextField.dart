import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final regex = RegExp(
  r"(^\+)|((?<=^\+)6)|((?<=^\+6)2)|((?<=^\+62)8)|((?<=^\+628\d*)\d)|(^0)|((?<=^0)8)|((?<=^08\d*)\d)",
);

final idStrictTextField = TextField(
  inputFormatters: [
    LengthLimitingTextInputFormatter(
      16,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
    ),
    FilteringTextInputFormatter.allow(
      regex,
    ),
  ],
);

class StrictPhoneTextField extends StatelessWidget {
  const StrictPhoneTextField.textfield({
    Key? key,
    this.textEditingController,
    this.initialValue,
    this.child,
    this.suffixIcon,
    this.prefixIcon,
    this.idStrictRegexTextField,
    this.onTap,
    this.onSubmit,
    this.onChanged,
    this.style,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.hintText,
    this.labelText,
    this.obsecureText = false,
    this.manualError = false,
    this.requiredMarking = false,
    this.readOnly = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String? initialValue;
  final Widget? child;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final VoidCallback? idStrictRegexTextField;
  final VoidCallback? onTap;

  final ValueChanged<String>? onSubmit;
  final ValueChanged<String>? onChanged;

  final List<TextInputFormatter>? inputFormatters;

  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

  final String? hintText;
  final String? labelText;

  final bool obsecureText;
  final bool? manualError;
  final bool? requiredMarking;
  final bool readOnly;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text.rich(
            TextSpan(
              text: labelText,
              children: requiredMarking!
                  ? null
                  : [
                      TextSpan(
                        text: '*',
                        style: style,
                      ),
                    ],
            ),
          ),
          const SizedBox()
        ],
        TextFormField(
          key: key,
          controller: textEditingController,
          initialValue: initialValue,
          obscureText: obsecureText,
          readOnly: readOnly,
          onFieldSubmitted: onSubmit,
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
            border: manualError == true
                ? OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8))
                : theme.inputDecorationTheme.border?.copyWith(
                    borderSide: BorderSide(color: theme.colorScheme.error)),
            enabledBorder: manualError == true
                ? OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  )
                : theme.inputDecorationTheme.enabledBorder,
            focusedBorder: manualError == true
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
        ),
      ],
    );
  }
}
