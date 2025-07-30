// test/login_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:pry_poliza/services/login_service.dart';

void main() {
  final service = LoginService();

  group('Validación de email', () {
    test('Email vacío', () {
      expect(service.validarEmail(''), 'El correo electrónico no puede estar vacío');
    });

    test('Email inválido', () {
      expect(service.validarEmail('correo@invalido'), 'Ingrese un correo electrónico válido');
    });

    test('Email válido', () {
      expect(service.validarEmail('test@email.com'), null);
    });
  });

  group('Validación de clave', () {
    test('Clave vacía', () {
      expect(service.validarClave(''), 'La contraseña no puede estar vacía');
    });

    test('Clave corta', () {
      expect(service.validarClave('1234567'), 'La contraseña debe tener al menos 8 caracteres');
    });

    test('Clave válida', () {
      expect(service.validarClave('12345678'), null);
    });
  });
}