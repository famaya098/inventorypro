class Transaccion {
  final String id;
  final String codigoTransaccion;
  final String creadoPor;
  final String fechaTransaccion;
  final String nombreProducto;
  final int stockInicial;
  final int stockFinal;
  final String tipoTransaccion;
  final int cantidadIngresada;

  Transaccion({
    required this.id,
    required this.codigoTransaccion,
    required this.creadoPor,
    required this.fechaTransaccion,
    required this.nombreProducto,
    required this.stockInicial,
    required this.stockFinal,
    required this.tipoTransaccion,
    required this.cantidadIngresada,
  });

  factory Transaccion.fromMap(String id, Map<String, dynamic> map) {
    return Transaccion(
      id: id,
      codigoTransaccion: map['codigoTransaccion'] ?? '',
      creadoPor: map['creadoPor'] ?? '',
      fechaTransaccion: map['fechaTransaccion'] ?? '',
      nombreProducto: map['nombreProducto'] ?? '',
      stockInicial: map['stockInicial'] ?? 0,
      stockFinal: map['stockFinal'] ?? 0,
      tipoTransaccion: map['tipoTransaccion'] ?? '',
      cantidadIngresada: map['cantidadIngresada'] ?? 0,
    );
  }
}