// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventorypro/home_screen.dart';
import 'package:inventorypro/my_drawer.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  File? _image;
  String? _nombreUsuario; // Variable para almacenar el nombre de usuario

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
    _obtenerNombreUsuario(); // Obtener el nombre de usuario al iniciar el estado
  }

  // Función para obtener el nombre de usuario actual
  void _obtenerNombreUsuario() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    // Obtener el UID del usuario actual
    String uid = user.uid;

    // Referencia al nodo de usuario correspondiente en la base de datos
    DatabaseReference ref = FirebaseDatabase.instance.reference().child('usuarios').child(uid);

    // Escuchar los cambios en el nodo del usuario
    ref.once().then((DataSnapshot snapshot) {
      // Verificar si el snapshot tiene datos antes de acceder a ellos
      if (snapshot.value != null) {
        // Obtener el nombre de usuario del snapshot
        String? nombreUsuario = snapshot.value!['username'];

        // Verificar si 'username' es nulo antes de asignarlo a _nombreUsuario
        if (nombreUsuario != null) {
          // Actualizar el estado con el nombre de usuario
          setState(() {
            _nombreUsuario = nombreUsuario;
          });
        }
      }
    } as FutureOr Function(DatabaseEvent value));
  }
}









  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
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
        backgroundColor: const Color(0xFF027A70), // Color de la AppBar
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
              onPressed: () {
                // Acción al presionar el botón "Guardar"
              },
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
            // Mostrar selector de imágenes
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