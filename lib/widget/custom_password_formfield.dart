import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets_flutter_and_material/widget/custom_textfield.dart';

class CustomPasswordFormField extends StatefulWidget {
  const CustomPasswordFormField({
    super.key,
    this.controller,
    this.requiredMarking = false,
    this.readOnly = false,
    this.textInputAction,
    this.hintText,
    this.initialValue,
    this.labelText,
    this.prefixIcon,
    this.visiblePasswordIcon,
    this.invisiblePasswordIcon,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.validator,
  });

  final TextEditingController? controller;
  final bool requiredMarking;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? initialValue;
  final String? labelText;
  final Widget? prefixIcon;
  final IconData? visiblePasswordIcon;
  final IconData? invisiblePasswordIcon;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _isObscuring = true;

  @override
  void dispose() {
    super.dispose();
    widget.controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      key: context.widget.key,
      controller: widget.controller,
      requiredMarking: widget.requiredMarking,
      obscureText: _isObscuring,
      readOnly: widget.readOnly,
      initialValue: widget.initialValue,
      keyboardType: _isObscuring ? null : TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      hintText: widget.hintText,
      labelText: widget.labelText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: SizedBox.shrink(
        child: IconButton(
          iconSize: 16.0,
          padding: EdgeInsets.zero,
          onPressed: () => setState(() => _isObscuring = !_isObscuring),
          icon: Icon(_isObscuring
              ? widget.invisiblePasswordIcon
              : widget.visiblePasswordIcon),
        ),
      ),
      inputFormatters: widget.inputFormatters,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
