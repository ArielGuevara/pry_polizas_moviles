import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioService {
  final _firestore = FirebaseFirestore.instance;

  Future<List<String>> obtenerUsuarios() async {
    final snapshot = await _firestore.collection('usuarios').get();
    // Puedes cambiar 'email' por el campo que quieras mostrar
    return snapshot.docs
        .map((doc) => doc.data()['email']?.toString() ?? 'Sin email')
        .toList();
  }
}