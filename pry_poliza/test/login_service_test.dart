import 'package:flutter_test/flutter_test.dart';
import 'package:pry_poliza/services/login_service.dart';

void main() {
  final service = LoginService();

  group('Validación de email', () {
    test('Email vacío', () {
      expect(service.validarEmail(''), 'El correo electrónico no puede estar vacío');
    });

    test('Email nulo', () {
      expect(service.validarEmail(null), 'El correo electrónico no puede estar vacío');
    });

    test('Email inválido sin @', () {
      expect(service.validarEmail('correosinArroba'), 'Ingrese un correo electrónico válido');
    });

    test('Email inválido sin dominio', () {
      expect(service.validarEmail('correo@'), 'Ingrese un correo electrónico válido');
    });

    test('Email válido', () {
      expect(service.validarEmail('test@email.com'), null);
    });

    test('Email válido con subdominios', () {
      expect(service.validarEmail('usuario@empresa.com.ec'), null);
    });
  });

  group('Validación de clave', () {
    test('Clave vacía', () {
      expect(service.validarClave(''), 'La contraseña no puede estar vacía');
    });

    test('Clave nula', () {
      expect(service.validarClave(null), 'La contraseña no puede estar vacía');
    });

    test('Clave muy corta (7 caracteres)', () {
      expect(service.validarClave('1234567'), 'La contraseña debe tener al menos 8 caracteres');
    });

    test('Clave válida (8 caracteres)', () {
      expect(service.validarClave('12345678'), null);
    });

    test('Clave válida (más de 8 caracteres)', () {
      expect(service.validarClave('contraseñaSegura123'), null);
    });
  });
}