import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton.elevated({
    Key? key,
    this.isLoading = false,
    this.onPressed,
    this.style,
    this.textButton = 'Submit',
    this.child,
  })  : _isElevated = 1,
        super(key: key);

  const SubmitButton.outlined({
    Key? key,
    this.isLoading = false,
    this.onPressed,
    this.style,
    this.textButton = 'Submit',
    this.child,
  })  : _isElevated = 2,
        super(key: key);

  const SubmitButton.textbutton({
    Key? key,
    this.isLoading = false,
    this.onPressed,
    this.style,
    this.textButton = 'Submit',
    this.child,
  })  : _isElevated = 3,
        super(key: key);

  /// the text to be displayed on the button. if child is not null, this wil be ignored
  final String? textButton;

  /// the widget to be displayed on the button.
  final Widget? child;

  final ButtonStyle? style;

  /// Weather to show child or loading indicator, if [false] child will be shown
  final bool isLoading;

  /// The callback to be called when the button is pressed and [isLoading] is false
  final VoidCallback? onPressed;

  final int _isElevated;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = this.onPressed == null
        ? null
        : () => isLoading ? null : this.onPressed!.call();
    final Widget child = isLoading
        ? SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.background)),
          )
        : this.child ?? Text(textButton!);

    if (_isElevated == 1) {
      return SizedBox(
        height: 51,
        child: ElevatedButton(
          style: style,
          onPressed: onPressed,
          child: child,
        ),
      );
    }
    if (_isElevated == 2) {
      return SizedBox(
        height: 51,
        child: OutlinedButton(
          onPressed: onPressed,
          child: child,
        ),
      );
    }
    return SizedBox(
        height: 51, child: TextButton(onPressed: onPressed, child: child));
  }
}
