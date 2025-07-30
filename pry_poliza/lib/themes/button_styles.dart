import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';

class AppButtonStyles {
  static ButtonStyle primary(BuildContext context) => ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).colorScheme.primary,
    foregroundColor: Theme.of(context).colorScheme.onPrimary,
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  );

  static ButtonStyle outline(BuildContext context) => OutlinedButton.styleFrom(
    foregroundColor: Theme.of(context).colorScheme.primary,
    side: BorderSide(color: Colors.white),
  );

  static ButtonStyle ancle(BuildContext context) => OutlinedButton.styleFrom(
    padding: EdgeInsets.zero, // Elimina el padding por defecto
    minimumSize: Size(50, 30), // Tamaño mínimo táctil
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    foregroundColor: Colors.white,
  );

  static ButtonStyle signIn(BuildContext context) => ElevatedButton.styleFrom(
    minimumSize: Size(140, 40), // Ancho: 200, Altura: 40 (ajusta estos valores)
    backgroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8), // Controla el espacio interno
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22), // Puedes ajustar el radio del borde
    ),
  );
  static ButtonStyle borderedWhite(BuildContext context) => OutlinedButton.styleFrom(
    minimumSize: const Size(140, 40),
    side: const BorderSide(
      color: Colors.white, // Color del borde
      width: 1.5,         // Grosor del borde
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
    ),
    foregroundColor: Colors.white, // Color del texto
    backgroundColor: Colors.transparent, // Fondo transparente
  );
}