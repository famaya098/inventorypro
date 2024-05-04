class Producto {
  final String id;
  final String nombre;
  final String codigo;
  final String descripcion;
  final String estatus;
  final int cantidad;
  final String unidad;
  final double precioCompra;
  final double precioVenta;
  final String fotoUrl;
  final String creadoPor;

  Producto({
    required this.id,
    required this.nombre,
    required this.codigo,
    required this.descripcion,
    required this.estatus,
    required this.cantidad,
    required this.unidad,
    required this.precioCompra,
    required this.precioVenta,
    required this.fotoUrl,
    required this.creadoPor,
  });

  factory Producto.fromMap(String id, Map<String, dynamic> map) {
    return Producto(
      id: id,
      nombre: map['nombre'] ?? '',
      codigo: map['codigo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      estatus: map['estatus'] ?? '',
      cantidad: map['cantidad'] ?? 0,
      unidad: map['unidad'] ?? '',
      precioCompra: map['precioCompra'] != null ? map['precioCompra'].toDouble() : 0.0,
      precioVenta: map['precioVenta'] != null ? map['precioVenta'].toDouble() : 0.0,
      fotoUrl: map['fotoUrl'] ?? '',
      creadoPor: map['creadoPor'] ?? '',
    );
  }
}