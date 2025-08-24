import 'package:flutter_test/flutter_test.dart';
import 'package:pry_poliza/viewmodels/poliza_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Mock para http.Client
class MockClient extends Mock implements http.Client {}

void main() {
  late PolizaViewModel viewModel;

  setUp(() {
    viewModel = PolizaViewModel();
  });

  group('PolizaViewModel Tests', () {
    test('Inicialización con valores por defecto', () {
      expect(viewModel.propietario, '');
      expect(viewModel.valorAlquiler, 0);
      expect(viewModel.modeloAuto, 'A');
      expect(viewModel.edadPropietario, '18-23');
      expect(viewModel.accidentes, 0);
      expect(viewModel.costoTotal, 0);
    });

    test('Método nuevo() resetea todos los valores', () {
      // Arrange - configurar datos
      viewModel.propietario = 'Juan';
      viewModel.valorAlquiler = 5000;
      viewModel.modeloAuto = 'B';
      viewModel.edadPropietario = '23-55';
      viewModel.accidentes = 2;
      viewModel.costoTotal = 1500;

      // Act - ejecutar acción
      viewModel.nuevo();

      // Assert - verificar resultados
      expect(viewModel.propietario, '');
      expect(viewModel.valorAlquiler, 0);
      expect(viewModel.modeloAuto, 'A');
      expect(viewModel.edadPropietario, '18-23');
      expect(viewModel.accidentes, 0);
      expect(viewModel.costoTotal, 0);
    });

    test('Asignación de valores funciona correctamente', () {
      viewModel.propietario = 'María González';
      viewModel.valorAlquiler = 8000;
      viewModel.modeloAuto = 'C';
      viewModel.edadPropietario = '55+';
      viewModel.accidentes = 1;

      expect(viewModel.propietario, 'María González');
      expect(viewModel.valorAlquiler, 8000);
      expect(viewModel.modeloAuto, 'C');
      expect(viewModel.edadPropietario, '55+');
      expect(viewModel.accidentes, 1);
    });
  });
}