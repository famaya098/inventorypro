import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventorypro/home_screen.dart';
import 'package:inventorypro/my_drawer.dart';
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
  String _codigo = Uuid().v4();
  File? _image;
  String? _nombreUsuario;
  String? _fotoUrl;

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
    _obtenerNombreUsuario();
  }

  void _obtenerNombreUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _nombreUsuario = user.displayName;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      Reference ref = FirebaseStorage.instance.ref().child('productos').child('${Uuid().v4()}.jpg');
      UploadTask uploadTask = ref.putFile(File(pickedImage.path));
      TaskSnapshot taskSnapshot = await uploadTask;
      String fotoUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _fotoUrl = fotoUrl;
      });
    }
  }

  Future<void> _guardarProducto() async {
    if (_validarCampos()) {
      String codigo = _codigo;
      String nombre = _nombreController.text;
      String descripcion = _descripcionController.text;
      double precioCompra = double.tryParse(_precioCompraController.text) ?? 0.0;
      double precioVenta = double.tryParse(_precioVentaController.text) ?? 0.0;
      int cantidad = int.tryParse(_cantidadController.text) ?? 0;
      String unidad = _unidadController.text;
      String creadoPor = _nombreUsuario ?? '';

      Map<String, dynamic> productoData = {
        'codigo': codigo,
        'nombre': nombre,
        'descripcion': descripcion,
        'precioCompra': precioCompra,
        'precioVenta': precioVenta,
        'cantidad': cantidad,
        'unidad': unidad,
        'creadoPor': creadoPor,
        'estatus': _selectedEstatus,
        'fotoUrl': _fotoUrl,
      };

      await FirebaseDatabase.instance.reference().child('productos').push().set(productoData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Producto agregado exitosamente'),
          duration: Duration(seconds: 2),
        ),
      );

      _limpiarCampos();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Todos los campos son obligatorios'),
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

  void _limpiarCampos() {
    _nombreController.clear();
    _descripcionController.clear();
    _precioCompraController.clear();
    _precioVentaController.clear();
    _cantidadController.clear();
    _unidadController.clear();
    _selectedEstatus = "Activo";
    _generarNuevoCodigoProducto();
    _image = null;
    _fotoUrl = null;
  }

  void _generarNuevoCodigoProducto() {
    setState(() {
      _codigo = Uuid().v4();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
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
            const Text(
              'Información del Producto',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF027A70),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Código de Producto',
              hintText: _codigo,
              enabled: false,
            ),
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
            _buildTextField(
              label: 'Creado por',
              hintText: _nombreUsuario ?? 'Nombre de usuario',
              enabled: false,
            ),
            _buildDropdownButton(),
            const SizedBox(height: 20),
            const Text(
              'Agregar Foto',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildImagePicker(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarProducto,
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es obligatorio';
            }
            return null;
          },
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es obligatorio';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _image == null
            ? Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Icon(Icons.photo, size: 50),
                ),
              )
            : Image.file(
                _image!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('Seleccionar de la galería'),
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_camera),
                        title: const Text('Tomar una foto'),
                        onTap: () {
                          _pickImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Text('Seleccionar Foto', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
