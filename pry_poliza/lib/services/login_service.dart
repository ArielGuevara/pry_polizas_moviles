import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginService {
  String _mensaje = "";

  String? validarEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'El correo electrónico no puede estar vacío';
    }
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Ingrese un correo electrónico válido';
    }
    return null; // El correo electrónico es válido
  }

  String? validarClave(String? clave) {
    if (clave == null || clave.isEmpty) {
      return 'La contraseña no puede estar vacía';
    }
    if (clave.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    return null; // La contraseña es válida
  }


  Future<String> login(TextEditingController _emailController,
      TextEditingController _passwordController,
      BuildContext context) async {

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      _mensaje = "Login exitoso: ${credential.user?.email}";
      Navigator.pushNamedAndRemoveUntil(
          context,
          '/poliza',
              (Route<dynamic> route) => false);
    } catch (e) {
      _mensaje = "Error: Ocurrió un error al iniciar sesión. Verifique sus credenciales.";
    }
    return _mensaje;
  }
}