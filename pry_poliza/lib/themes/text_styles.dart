import 'package:flutter/material.dart';

class AppTextStyles {
  // Estilo que puede ir en TextTheme (sin contexto)
  static const input = TextStyle(
    fontSize: 18,
    color: Colors.white
  );

  static const button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );

  static const heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );

  // Versiones con contexto para cuando necesites colores dinámicos
  static TextStyle inputWithContext(BuildContext context) => input.copyWith(
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle headingWithContext(BuildContext context) => heading.copyWith(
    color: Theme.of(context).colorScheme.primary,
  );
}