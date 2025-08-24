import 'package:flutter_test/flutter_test.dart';
import 'package:pry_poliza/models/poliza_model.dart';

void main() {
  group('Poliza Model Tests', () {
    test('Constructor crea instancia correctamente', () {
      final poliza = Poliza(
        propietario: 'Juan Pérez',
        valor: 5000.0,
        modeloAuto: 'B',
        edadPropietario: '23-55',
        accidentes: 1,
        costoTotal: 6200.0,
      );

      expect(poliza.propietario, 'Juan Pérez');
      expect(poliza.valor, 5000.0);
      expect(poliza.modeloAuto, 'B');
      expect(poliza.edadPropietario, '23-55');
      expect(poliza.accidentes, 1);
      expect(poliza.costoTotal, 6200.0);
    });

    test('fromJson() convierte JSON correctamente', () {
      final json = {
        'propietario': 'María González',
        'valorSeguroAuto': 8000,
        'modeloAuto': 'C',
        'edadPropietario': '55+',
        'accidentes': 2,
        'costoTotal': 10400.0,
      };

      final poliza = Poliza.fromJson(json);

      expect(poliza.propietario, 'María González');
      expect(poliza.valor, 8000.0);
      expect(poliza.modeloAuto, 'C');
      expect(poliza.edadPropietario, '55+');
      expect(poliza.accidentes, 2);
      expect(poliza.costoTotal, 10400.0);
    });

    test('toJson() convierte a JSON correctamente', () {
      final poliza = Poliza(
        propietario: 'Carlos Ruiz',
        valor: 3000.0,
        modeloAuto: 'A',
        edadPropietario: '18-23',
        accidentes: 0,
        costoTotal: 4125.0,
      );

      final json = poliza.toJson();

      expect(json['propietario'], 'Carlos Ruiz');
      expect(json['valorSeguroAuto'], 3000.0);
      expect(json['modeloAuto'], 'A');
      expect(json['edadPropietario'], '18-23');
      expect(json['accidentes'], 0);
      expect(json['costoTotal'], 4125.0);
    });

    test('Conversión JSON ida y vuelta mantiene datos', () {
      final polizaOriginal = Poliza(
        propietario: 'Ana Torres',
        valor: 7500.0,
        modeloAuto: 'B',
        edadPropietario: '23-55',
        accidentes: 3,
        costoTotal: 9300.0,
      );

      final json = polizaOriginal.toJson();
      final polizaReconstruida = Poliza.fromJson(json);

      expect(polizaReconstruida.propietario, polizaOriginal.propietario);
      expect(polizaReconstruida.valor, polizaOriginal.valor);
      expect(polizaReconstruida.modeloAuto, polizaOriginal.modeloAuto);
      expect(polizaReconstruida.edadPropietario, polizaOriginal.edadPropietario);
      expect(polizaReconstruida.accidentes, polizaOriginal.accidentes);
      expect(polizaReconstruida.costoTotal, polizaOriginal.costoTotal);
    });
  });
}