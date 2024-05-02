import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({Key? key}) : super(key: key);

  @override
  _ProductosScreenState createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _precioCompraController;
  late TextEditingController _precioVentaController;
  late TextEditingController _cantidadController;
  late TextEditingController _unidadController;
  late String _selectedEstatus;
  late String _codigo;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _descripcionController = TextEditingController();
    _precioCompraController = TextEditingController();
    _precioVentaController = TextEditingController();
    _cantidadController = TextEditingController();
    _unidadController = TextEditingController();
    _selectedEstatus = "Activo";
    _codigo = Uuid().v4(); // Generar un código único al iniciar el estado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Producto'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información del Producto',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildTextField('Código', _codigo, enabled: false),
            _buildTextField('Nombre', _nombreController.text, controller: _nombreController),
            _buildTextField('Descripción', _descripcionController.text, controller: _descripcionController),
            SizedBox(height: 20),
            Text(
              'Detalles de la Compra',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildTextField('Precio de Compra', _precioCompraController.text, controller: _precioCompraController, keyboardType: TextInputType.number),
            _buildTextField('Precio de Venta', _precioVentaController.text, controller: _precioVentaController, keyboardType: TextInputType.number),
            _buildTextField('Cantidad que Ingresa', _cantidadController.text, controller: _cantidadController, keyboardType: TextInputType.number),
            _buildTextField('Unidad', _unidadController.text, controller: _unidadController),
            _buildDropdownButton(),
            SizedBox(height: 20),
            Text(
              'Agregar Foto',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildImagePicker(),
            SizedBox(height: 20),
            Text(
              'Creado por: ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Usuario actual'), // Aquí puedes mostrar el usuario actual
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón "Guardar"
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value, {TextEditingController? controller, TextInputType? keyboardType, bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: value,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estatus',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8),
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
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          color: Colors.grey.withOpacity(0.2),
          child: Icon(Icons.photo),
        ),
        SizedBox(height: 8),
        TextButton(
          onPressed: () {
            // Mostrar selector de imágenes
          },
          child: Text('Seleccionar Foto'),
        ),
      ],
    );
  }
}