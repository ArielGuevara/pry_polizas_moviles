import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/poliza_model.dart';

class PolizaService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> guardarPoliza(Poliza poliza) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("Usuario no autenticado");

    await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('polizas')
        .add(poliza.toJson());
  }

  Future<List<Poliza>> obtenerPolizas() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("Usuario no autenticado");

    final snapshot = await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('polizas')
        .get();

    return snapshot.docs
        .map((doc) => Poliza.fromJson(doc.data()))
        .toList();
  }
}