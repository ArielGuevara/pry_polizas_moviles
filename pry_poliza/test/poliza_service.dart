// test/poliza_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:pry_poliza/services/poliza_service.dart';
import 'package:pry_poliza/models/poliza_model.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  test('Guardar y obtener póliza', () async {
    final firestore = MockFirestoreInstance();
    final user = MockUser(uid: 'abc123');
    final auth = MockFirebaseAuth(mockUser: user);

    final service = PolizaService();
    service._firestore = firestore;
    FirebaseAuth.instance = auth;

    final poliza = Poliza(
      propietario: 'Juan',
      valor: 1000,
      modeloAuto: 'A',
      edadPropietario: '23-55',
      accidentes: 0,
      costoTotal: 1200,
    );

    await service.guardarPoliza(poliza);
    final polizas = await service.obtenerPolizas();

    expect(polizas.length, 1);
    expect(polizas.first.propietario, 'Juan');
  });
}