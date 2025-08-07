import 'package:flutter/material.dart';

class DrawerViewModel extends ChangeNotifier {

  // Se maneja el estado del Drawer de la aplicación.
  String _selected = 'Home';
  // getter publico pueda acceder al valor actual
  String get selected => _selected;

  // Metodo, cambiar la pagina seleccionada
  void selct(String page){
    _selected = page;
    notifyListeners(); // Notifica a los widgets que escuchan este modelo que el estado ha cambiado.
  }
}