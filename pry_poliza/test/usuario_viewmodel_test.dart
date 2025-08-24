import 'package:flutter_test/flutter_test.dart';
import 'package:pry_poliza/viewmodels/usuario_viewmodel.dart';

void main() {
  late UsuarioViewModel viewModel;

  setUp(() {
    viewModel = UsuarioViewModel();
  });

  group('UsuarioViewModel Tests', () {
    test('Inicialización con valores vacíos', () {
      expect(viewModel.nombre, '');
      expect(viewModel.correo, '');
      expect(viewModel.telefono, '');
    });

    test('actualizarNombre() cambia el nombre correctamente', () {
      const nuevoNombre = 'Juan Pérez';
      viewModel.actualizarNombre(nuevoNombre);
      expect(viewModel.nombre, nuevoNombre);
    });

    test('actualizarCorreo() cambia el correo correctamente', () {
      const nuevoCorreo = 'juan@email.com';
      viewModel.actualizarCorreo(nuevoCorreo);
      expect(viewModel.correo, nuevoCorreo);
    });

    test('actualizarTelefono() cambia el teléfono correctamente', () {
      const nuevoTelefono = '+593987654321';
      viewModel.actualizarTelefono(nuevoTelefono);
      expect(viewModel.telefono, nuevoTelefono);
    });

    test('limpiarCampos() resetea todos los valores', () {
      // Arrange
      viewModel.actualizarNombre('Juan');
      viewModel.actualizarCorreo('juan@email.com');
      viewModel.actualizarTelefono('123456789');

      // Act
      viewModel.limpiarCampos();

      // Assert
      expect(viewModel.nombre, '');
      expect(viewModel.correo, '');
      expect(viewModel.telefono, '');
    });

    test('Múltiples actualizaciones funcionan correctamente', () {
      viewModel.actualizarNombre('Ana');
      viewModel.actualizarCorreo('ana@email.com');
      viewModel.actualizarTelefono('987654321');

      expect(viewModel.nombre, 'Ana');
      expect(viewModel.correo, 'ana@email.com');
      expect(viewModel.telefono, '987654321');

      viewModel.actualizarNombre('Ana María');
      expect(viewModel.nombre, 'Ana María');
      expect(viewModel.correo, 'ana@email.com'); // No debe cambiar
      expect(viewModel.telefono, '987654321'); // No debe cambiar
    });
  });
}