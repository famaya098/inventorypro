//agregar_usuario_screen


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventorypro/home_screen.dart';
import 'package:inventorypro/my_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'dart:io';
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference _databaseReference =
    FirebaseDatabase.instance.reference();

class AgregarUsuariosScreen extends StatefulWidget {
  const AgregarUsuariosScreen({Key? key}) : super(key: key);

  @override
  _AgregarUsuariosScreenState createState() => _AgregarUsuariosScreenState();
}

class _AgregarUsuariosScreenState extends State<AgregarUsuariosScreen> {
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _duiController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _fechaNacimientoController =
      TextEditingController();
  final TextEditingController _creadoPorController = TextEditingController();
  final TextEditingController _tipoPermisoController = TextEditingController();
  String _fotoUrl = "";
  String _selectedPermiso = 'Administrador';
  late File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Usuario'),
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
             const Center(
              child: Text(
                'Información Personal',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF027A70),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextFormField(
                label: 'Nombres', hintText: '', controller: _nombresController),
            _buildTextFormField(
                label: 'Apellidos',
                hintText: '',
                controller: _apellidosController),
            _buildTextFormField(
                label: 'Email', hintText: '', controller: _emailController),
            _buildTextFormField(
                label: 'Contraseña',
                hintText: '',
                obscureText: true,
                controller: _contrasenaController),
            _buildTextFormField(
                label: 'DUI',
                hintText: '',
                keyboardType: TextInputType.number,
                controller: _duiController),
            _buildTextFormField(
                label: 'Username',
                hintText: '',
                controller: _usernameController),
            _buildTextFormField(
                label: 'Teléfono',
                hintText: '',
                keyboardType: TextInputType.phone,
                controller: _telefonoController),
            _buildTextFormField(
                label: 'Dirección',
                hintText: '',
                controller: _direccionController),
            _buildTextFormField(
                label: 'Creado por',
                hintText: '',
                controller: _creadoPorController),

            const SizedBox(height: 20),
            _buildDatePicker(context, 'Fecha Nacimiento'),
            const SizedBox(height: 20),
            _buildPhotoPicker(context, 'Agregar Foto'),
            const SizedBox(height: 20),
            _buildTextFormField(
                label: 'Fecha Creación',
                hintText: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
                readOnly:
                    true), // Utiliza DateFormat para formatear la fecha y hora actual

            const SizedBox(height: 20),
            _buildDropdownButton(
                context, 'Tipo de Permiso', ['Administrador', 'Usuario']),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Verificar si se seleccionó una foto
                  if (_fotoUrl.isNotEmpty) {
                    // Obtener los valores de los campos solo si se ha seleccionado una foto
                    String nombres = _nombresController.text;
                    String apellidos = _apellidosController.text;
                    String email = _emailController.text;
                    String contrasena = _contrasenaController.text;
                    String dui = _duiController.text;
                    String username = _usernameController.text;
                    String telefono = _telefonoController.text;
                    String direccion = _direccionController.text;
                    String fechaNacimiento = _fechaNacimientoController.text;
                    String creadoPor = _creadoPorController.text;
                    String tipoPermiso =
                        _selectedPermiso; // Usa el valor seleccionado del DropdownButtonFormField

                    // Registrar al usuario en Firebase Authentication
                    await _registerUserWithEmailAndPassword(email, contrasena);

                    // Obtener el ID del usuario recién creado
                    User? user = FirebaseAuth.instance.currentUser;
                    String uid = user?.uid ?? '';

                    // Construir el objeto de usuario
                    Map<String, dynamic> userData = {
                      'uid': uid, // Agregar el UID único del usuario
                      'nombres': nombres,
                      'apellidos': apellidos,
                      'email': email,
                      'contrasena': contrasena,
                      'dui': dui,
                      'username': username,
                      'telefono': telefono,
                      'direccion': direccion,
                      'fechaNacimiento': fechaNacimiento,
                      'fotoUrl':
                          _fotoUrl, // Utilizar la URL de la foto obtenida de Firebase Storage
                      'fechaCreacion':
                          DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
                      'creadoPor': creadoPor,
                      'tipoPermiso': tipoPermiso,
                    };

                    // Enviar los datos a Firebase Realtime Database
                    await _databaseReference
                        .child('usuarios')
                        .push()
                        .set(userData);

                    // Mostrar notificación de éxito
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Usuario registrado exitosamente'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // Limpiar los campos después de guardar
                    _nombresController.clear();
                    _apellidosController.clear();
                    _emailController.clear();
                    _contrasenaController.clear();
                    _duiController.clear();
                    _usernameController.clear();
                    _telefonoController.clear();
                    _direccionController.clear();
                    _fechaNacimientoController.clear();
                    _creadoPorController.clear();
                    _fotoUrl = '';
                    _image = null;
                    setState(() {_image = null;});
                    _selectedPermiso =
                        'Administrador'; // Restablecer el valor del DropdownButtonFormField
                  } else {
                    // Si no se seleccionó una foto, mostrar un mensaje de error
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: Text(
                              'Por favor, selecciona una foto antes de guardar.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF027A70),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Center(
                child: Text(
                  'Guardar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              
                  
                 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    bool readOnly = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
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
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es requerido';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        // Actualiza el valor del campo de fecha de nacimiento
        _fechaNacimientoController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget _buildPhotoPicker(BuildContext context, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: () => _selectImage(context),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _fotoUrl.isEmpty ? 'Seleccionar Foto' : 'Cambiar Foto',
                style: const TextStyle(fontSize: 16),
              ),
              if (_fotoUrl.isNotEmpty)
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(_fotoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}

Future<void> _selectImage(BuildContext context) async {
  final picker = ImagePicker();
  final pickedImage = await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Seleccionar de la galería'),
              onTap: () async {
                Navigator.pop(context, await picker.getImage(source: ImageSource.gallery));
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Tomar una foto'),
              onTap: () async {
                Navigator.pop(context, await picker.getImage(source: ImageSource.camera));
              },
            ),
          ],
        ),
      );
    },
  );

  if (pickedImage != null) {
    // Subir la imagen a Firebase Storage
    Reference ref =
        FirebaseStorage.instance.ref().child('fotos/${DateTime.now()}.jpg');
    UploadTask uploadTask = ref.putFile(File(pickedImage.path));

    // Esperar a que la imagen se haya subido correctamente
    TaskSnapshot taskSnapshot = await uploadTask;
    String fotoUrl = await taskSnapshot.ref.getDownloadURL();

    // Actualizar la URL de la foto
    setState(() {
      _fotoUrl = fotoUrl;
    });
  }
}



  Future<void> _registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      // Registra al usuario en Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Si el registro es exitoso, puedes imprimir el ID de usuario
      print('User registered: ${userCredential.user?.uid}');
    } catch (e) {
      // Maneja cualquier error que pueda ocurrir durante el registro
      print('Error registering user: $e');
      // Aquí puedes mostrar un mensaje de error al usuario o manejar la situación de otra manera
    }
  }

  Widget _buildDropdownButton(
      BuildContext context, String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value:
              _selectedPermiso, // Usa la variable para establecer el valor inicial
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            // Actualiza el valor seleccionado cuando cambia el DropdownButtonFormField
            setState(() {
              _selectedPermiso = value!;
            });
          },
        ),
      ],
    );
  }
}