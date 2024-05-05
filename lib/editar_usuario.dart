import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'clase_usuario.dart';

class EditarUsuario extends StatefulWidget {
  final Usuario usuario;

  const EditarUsuario({Key? key, required this.usuario}) : super(key: key);

  @override
  _EditarUsuarioState createState() => _EditarUsuarioState();
}

class _EditarUsuarioState extends State<EditarUsuario> {
  late TextEditingController _nombresController;
  late TextEditingController _apellidosController;
  late TextEditingController _emailController;
  late TextEditingController _contrasenaController;
  late TextEditingController _duiController;
  late TextEditingController _usernameController;
  late TextEditingController _telefonoController;
  late TextEditingController _direccionController;
  late TextEditingController _creadoPorController;

  @override
  void initState() {
    super.initState();
    _nombresController = TextEditingController(text: widget.usuario.nombres);
    _apellidosController = TextEditingController(text: widget.usuario.apellidos);
    _emailController = TextEditingController(text: widget.usuario.email);
    _contrasenaController = TextEditingController(text: widget.usuario.contrasena);
    _duiController = TextEditingController(text: widget.usuario.dui);
    _usernameController = TextEditingController(text: widget.usuario.username);
    _telefonoController = TextEditingController(text: widget.usuario.telefono);
    _direccionController = TextEditingController(text: widget.usuario.direccion);
    _creadoPorController = TextEditingController(text: widget.usuario.creadoPor);
  }

  @override
  void dispose() {
    _nombresController.dispose();
    _apellidosController.dispose();
    _emailController.dispose();
    _contrasenaController.dispose();
    _duiController.dispose();
    _usernameController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    _creadoPorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(label: 'Nombres', controller: _nombresController),
            _buildTextField(label: 'Apellidos', controller: _apellidosController),
            _buildTextField(label: 'Email', controller: _emailController),
            _buildTextField(label: 'Contraseña', controller: _contrasenaController, obscureText: true),
            _buildTextField(label: 'DUI', controller: _duiController, keyboardType: TextInputType.number),
            _buildTextField(label: 'Username', controller: _usernameController),
            _buildTextField(label: 'Teléfono', controller: _telefonoController, keyboardType: TextInputType.phone),
            _buildTextField(label: 'Dirección', controller: _direccionController),
            _buildTextField(label: 'Creado por', controller: _creadoPorController),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _guardarCambios,
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    bool readOnly = false,
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
            hintText: '',
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
        ),
      ],
    );
  }

  void _guardarCambios() {
    // Actualizar los datos en Firebase
    var nuevoUsuario = Usuario(
      id: widget.usuario.id,
      nombres: _nombresController.text,
      apellidos: _apellidosController.text,
      email: _emailController.text,
      contrasena: _contrasenaController.text,
      dui: _duiController.text,
      username: _usernameController.text,
      telefono: _telefonoController.text,
      direccion: _direccionController.text,
      creadoPor: _creadoPorController.text,
      fechaNacimiento: widget.usuario.fechaNacimiento,
      fechaCreacion: widget.usuario.fechaCreacion,
      tipoPermiso: widget.usuario.tipoPermiso,
      fotoUrl: widget.usuario.fotoUrl,
    );

    DatabaseReference usuariosRef = FirebaseDatabase.instance.reference().child('usuarios');
    usuariosRef.child(widget.usuario.id).update(nuevoUsuario.toMap()).then((_) {
      Fluttertoast.showToast(
        msg: 'Usuario actualizado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: 'Error al actualizar usuario',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }
}