class Poliza {
  final String propietario;
  final double valor;
  final String modeloAuto;
  final String edadPropietario;
  final int accidentes;
  final double costoTotal;

  Poliza({
    required this.propietario,
    required this.valor,
    required this.modeloAuto,
    required this.edadPropietario,
    required this.accidentes,
    required this.costoTotal,
  });

  factory Poliza.fromJson(Map<String, dynamic> json) => Poliza(
        propietario: json['propietario'],
        modeloAuto: json['modeloAuto'],
        valor: json['valorSeguroAuto'].toDouble(),
        edadPropietario: json['edadPropietario'], // int
        accidentes: json['accidentes'],
        costoTotal: json['costoTotal'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'propietario': propietario,
        'valorSeguroAuto': valor,
        'modeloAuto': modeloAuto,
        'edadPropietario': edadPropietario, // int
        'accidentes': accidentes,
        'costoTotal': costoTotal,
      };
}