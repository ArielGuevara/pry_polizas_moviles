import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterService {

  String _mensaje = '';

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

  // ...otros imports

  Future<String> register(TextEditingController _emailController,
      TextEditingController _passwordController,
      BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Guarda el usuario en Firestore
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(credential.user!.uid)
          .set({'email': _emailController.text.trim()});

      Navigator.pushNamedAndRemoveUntil(
          context,
          '/poliza',
          (Route<dynamic> route) => false);
      return "Registro exitoso: ${credential.user?.email}";
    } catch (e) {
      return "Error: $e";
    }
  }
}
