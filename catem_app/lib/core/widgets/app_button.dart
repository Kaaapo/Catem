import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary }

/// Boton base del design system: estados normal / disabled / loading.
/// Los tokens visuales (colores, radios, tipografia) llegan por el ThemeData (CATEM-74).
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              if (icon != null) Icon(icon, size: 20),
              Text(label),
            ],
          );
    final callback = isLoading ? null : onPressed;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: switch (variant) {
        AppButtonVariant.primary => FilledButton(
          onPressed: callback,
          child: child,
        ),
        AppButtonVariant.secondary => OutlinedButton(
          onPressed: callback,
          child: child,
        ),
      },
    );
  }
}
