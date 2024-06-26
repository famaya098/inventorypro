import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Importar la librería intl para formatear la fecha
import 'package:uuid/uuid.dart'; // Importar la librería uuid
import 'package:firebase_database/firebase_database.dart'; // Importar la librería para interactuar con Firebase
import 'my_drawer.dart';

class AgregarTransac extends StatefulWidget {
  const AgregarTransac({Key? key}) : super(key: key);

  @override
  _AgregarTransacState createState() => _AgregarTransacState();
}

class _AgregarTransacState extends State<AgregarTransac> {
  final DatabaseReference _productosRef =
      FirebaseDatabase.instance.reference().child('productos');
  List<String> _productosList = [];
  String? _selectedProducto;
  String? _selectedTipoTransaccion; // Nueva variable para almacenar el tipo de transacción seleccionado
  String _codigoTransaccion = '';
  int? _stockProducto;
  int? _cantidad = 0;

  final _stockProductoSubject = BehaviorSubject<int?>();
  final _cantidadController = TextEditingController();

  final DatabaseReference _transaccionesRef =
    FirebaseDatabase.instance.reference().child('transaccion_producto');

  @override
void initState() {
  super.initState();
  _loadProductos();
  _generarCodigoTransaccion();
  _cantidad = 0; // Inicializar _cantidad con 0
}

  void _loadProductos() {
    _productosRef.onValue.listen((DatabaseEvent event) {
      Map<dynamic, dynamic> values =
          event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _productosList =
            values.values.map<String>((value) => value['nombre']).toList();
      });
    });
  }

  // Función para generar el código de transacción
  void _generarCodigoTransaccion() {
    setState(() {
      _codigoTransaccion = Uuid().v4();
    });
  }

  // Función para obtener el stock del producto seleccionado
 Future<int?> _obtenerStockProducto(String productoSeleccionado) async {
  try {
    final snapshot = await _productosRef.get();
    final productosMap = snapshot.value as Map<dynamic, dynamic>?;
    if (productosMap != null) {
      for (final entry in productosMap.entries) {
        final value = entry.value as Map<dynamic, dynamic>;
        if (value['nombre'] == productoSeleccionado) {
          final stockValue = value['cantidad'];
          if (stockValue is String) {
            return int.tryParse(stockValue);
          } else if (stockValue is int) {
            return stockValue;
          }
        }
      }
    }
    return null;
  } catch (e) {
    print('Error al obtener el stock del producto: $e');
    return null;
  }
}

  @override
  Widget build(BuildContext context) {
    String fechaActual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('InventoryPro'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
        backgroundColor: const Color(0xFF027A70),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'VENTAS Y COMPRAS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF027A70),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextFormField(
              label: 'Código Transacción:',
              hintText: _codigoTransaccion,
              enabled: false,
            ), 
            const SizedBox(height: 20),
            _buildTextFormField(
              label: 'Fecha:',
              hintText: fechaActual,
              keyboardType: TextInputType.datetime,
              enabled: false,
            ), 
            
            const SizedBox(height: 20),
            _buildDropdownButton(
              label: 'Producto:',
              items: _productosList,
              onChanged: (value) async {
                setState(() {
                  _selectedProducto = value;
                });
                if (value != null) {
                  _stockProducto = await _obtenerStockProducto(value);
                }
              },
            ),
            const SizedBox(height: 20),
            _buildTextFormField(
              label: 'Stock:',
              hintText: _stockProducto?.toString() ?? '',
              
              keyboardType: TextInputType.number,
              enabled: false,
              
            ),
            const SizedBox(height: 20),
            _buildTextFormField(
  label: 'Cantidad:',
  hintText: '',
  keyboardType: TextInputType.number,
  controller: _cantidadController,
),
            const SizedBox(height: 20),
            _buildDropdownButton(
              label: 'Tipo Transacción:',
              items: ['Entrada', 'Salida'],
              onChanged: (value) {
                setState(() {
                  _selectedTipoTransaccion = value;
                });
              },
            ),
            
            
            const SizedBox(height: 20),
            _buildTextFormField(
              label: 'Total Stock:',
              hintText: _calcularTotalStock(),
              keyboardType: TextInputType.number,
              enabled: false,
            ),
            const SizedBox(height: 20),
            _buildTextFormField(
              label: 'Creado por:',
              hintText: 'fre098',
              keyboardType: TextInputType.text,
              enabled: false, // Deshabilitar la edición
            ),
            const SizedBox(height: 20),
            Center(
  child: ElevatedButton(
    onPressed: _guardarTransaccion,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF027A70),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: const Text(
      'Guardar',
      style: TextStyle(fontSize: 18, color: Colors.white),
    ),
  ),
),
          ],
        ),
      ),
    );
  }

  Future<void> _guardarTransaccion() async {
    final codigoTransaccion = _codigoTransaccion;
    final fecha = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final nombreProducto = _selectedProducto;
    final stock = _stockProducto;
    final cantidad = int.tryParse(_cantidadController.text) ?? 0;
    final tipoTransaccion = _selectedTipoTransaccion;
    final totalStock = int.tryParse(_calcularTotalStock()) ?? 0;
    final creadoPor = 'fre098';

    // Validar que todos los campos estén completos
    if (nombreProducto == null || tipoTransaccion == null || cantidad == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor completa todos los campos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Guardar la transacción
    try {
      final nuevoNodo = _transaccionesRef.push();
      await nuevoNodo.set({
        'codigoTransaccion': codigoTransaccion,
        'fechaTransaccion': fecha,
        'nombreProducto': nombreProducto,
        'stockInicial': stock,
        'cantidadIngresada': cantidad,
        'tipoTransaccion': tipoTransaccion,
        'stockFinal': totalStock,
        'creadoPor': creadoPor,
      });

      final productoSnapshot = await _productosRef.get();
      final productosMap = productoSnapshot.value as Map<dynamic, dynamic>?;
      if (productosMap != null) {
        for (final entry in productosMap.entries) {
          final key = entry.key;
          final value = entry.value as Map<dynamic, dynamic>;
          if (value['nombre'] == nombreProducto) {
            await _productosRef.child(key).update({'cantidad': totalStock});
            break;
          }
        }
      }

      _cantidadController.clear();
      setState(() {
        _selectedTipoTransaccion = null;
        _generarCodigoTransaccion();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transacción exitosa'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error al guardar la transacción: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar la transacción'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildTextFormField({
  required String label,
  required String hintText,
  TextInputType? keyboardType,
  bool enabled = true,
  TextEditingController? controller, // Agregar este parámetro
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      const SizedBox(height: 8),
      if (label == 'Stock:')
        TextFormField(
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: _stockProducto?.toString() ?? '',
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          keyboardType: TextInputType.number,
          enabled: false,
        )
      else
        TextFormField(
          controller: controller, // Utilizar el controlador proporcionado
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          keyboardType: keyboardType,
          enabled: enabled,
        ),
    ],
  );
}

  Widget _buildDropdownButton({required String label, required List<String> items, required void Function(String?) onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      const SizedBox(height: 8),
      DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        value: label == 'Tipo Transacción:' ? _selectedTipoTransaccion : _selectedProducto, // Usar la variable correspondiente
        hint: const Text('Seleccionar'),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        iconSize: 36,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        onChanged: onChanged, // Usar la función de callback proporcionada
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ],
  );
}

String _calcularTotalStock() {
  int? cantidad = int.tryParse(_cantidadController.text);

  if (_selectedTipoTransaccion == 'Entrada' && cantidad != null) {
    return ((_stockProducto ?? 0) + cantidad).toString(); // Sumar la cantidad ingresada al stock actual
  } else if (_selectedTipoTransaccion == 'Salida' && cantidad != null) {
    int totalStock = (_stockProducto ?? 0) - cantidad;
    return totalStock >= 0 ? totalStock.toString() : 'No hay suficiente stock para la salida';
  } else {
    return _stockProducto?.toString() ?? ''; // Si no se ha seleccionado un tipo de transacción o no se ha ingresado una cantidad, mostrar el stock actual
  }
}



}
