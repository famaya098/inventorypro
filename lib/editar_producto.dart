import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class EditarProducto extends StatefulWidget {
  final String productId;
  final Map<String, dynamic> productData;

  const EditarProducto({Key? key, required this.productId, required this.productData}) : super(key: key);

  @override
  _EditarProductoState createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProducto> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _precioCompraController;
  late TextEditingController _precioVentaController;
  late TextEditingController _cantidadController;
  late TextEditingController _unidadController;
  late String _selectedEstatus;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.productData['nombre']);
    _descripcionController = TextEditingController(text: widget.productData['descripcion']);
    _precioCompraController = TextEditingController(text: widget.productData['precioCompra'].toString());
    _precioVentaController = TextEditingController(text: widget.productData['precioVenta'].toString());
    _cantidadController = TextEditingController(text: widget.productData['cantidad'].toString());
    _unidadController = TextEditingController(text: widget.productData['unidad']);
    _selectedEstatus = widget.productData['estatus'];
  }

  Future<void> _actualizarProducto() async {
    if (_validarCampos()) {
      String nombre = _nombreController.text;
      String descripcion = _descripcionController.text;
      double precioCompra = double.tryParse(_precioCompraController.text) ?? 0.0;
      double precioVenta = double.tryParse(_precioVentaController.text) ?? 0.0;
      int cantidad = int.tryParse(_cantidadController.text) ?? 0;
      String unidad = _unidadController.text;

      Map<String, dynamic> productoData = {
        'nombre': nombre,
        'descripcion': descripcion,
        'precioCompra': precioCompra,
        'precioVenta': precioVenta,
        'cantidad': cantidad,
        'unidad': unidad,
        'estatus': _selectedEstatus,
      };

      await FirebaseDatabase.instance.reference().child('productos').child(widget.productId).update(productoData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Producto actualizado exitosamente'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context); // Regresar a la pantalla anterior después de actualizar
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Todos los campos son obligatorios'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  bool _validarCampos() {
    return _nombreController.text.isNotEmpty &&
        _descripcionController.text.isNotEmpty &&
        _precioCompraController.text.isNotEmpty &&
        _precioVentaController.text.isNotEmpty &&
        _cantidadController.text.isNotEmpty &&
        _unidadController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InventoryPro'),
        backgroundColor: const Color(0xFF027A70),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Editar Producto',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF027A70),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Nombre',
              hintText: '',
              controller: _nombreController,
            ),
            _buildTextField(
              label: 'Descripción',
              hintText: '',
              controller: _descripcionController,
            ),
            _buildTextField(
              label: 'Precio de Compra',
              hintText: "\$0.0",
              controller: _precioCompraController,
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              label: 'Precio de Venta',
              hintText: '\$0.0',
              controller: _precioVentaController,
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              label: 'Cantidad',
              hintText: '',
              controller: _cantidadController,
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              label: 'Tipo Unidad',
              hintText: '',
              controller: _unidadController,
            ),
            _buildDropdownButton(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _actualizarProducto,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF027A70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
              child: const Center(
                child: Text(
                  'Actualizar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 16),
          keyboardType: keyboardType,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Estatus',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedEstatus,
          items: ["Activo", "Inactivo", "Descontinuado"].map((estatus) {
            return DropdownMenuItem<String>(
              value: estatus,
              child: Text(estatus),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedEstatus = newValue!;
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
