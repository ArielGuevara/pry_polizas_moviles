import 'package:flutter/material.dart';

class UsuarioViewModel extends ChangeNotifier {
  String nombre = '';
  String correo = '';
  String telefono = '';

  void actualizarNombre(String nuevoNombre) {
    nombre = nuevoNombre;
    notifyListeners();
  }

  void actualizarCorreo(String nuevoCorreo) {
    correo = nuevoCorreo;
    notifyListeners();
  }

  void actualizarTelefono(String nuevoTelefono) {
    telefono = nuevoTelefono;
    notifyListeners();
  }

  void limpiarCampos() {
    nombre = '';
    correo = '';
    telefono = '';
    notifyListeners();
  }
}