// test/usuario_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:pry_poliza/services/usuario_service.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  test('Obtener usuarios retorna lista de emails', () async {
    final instance = MockFirestoreInstance();
    await instance.collection('usuarios').add({'email': 'test@correo.com'});
    await instance.collection('usuarios').add({'email': 'otro@correo.com'});

    final service = UsuarioService();
    // Sobrescribe el firestore interno para pruebas
    service._firestore = instance;

    final usuarios = await service.obtenerUsuarios();
    expect(usuarios, contains('test@correo.com'));
    expect(usuarios, contains('otro@correo.com'));
  });
}