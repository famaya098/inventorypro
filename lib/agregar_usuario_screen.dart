import 'package:intl/intl.dart'; 
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventorypro/home_screen.dart';
import 'package:inventorypro/my_drawer.dart';

class AgregarUsuariosScreen extends StatelessWidget {
  const AgregarUsuariosScreen({Key? key});

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
            const Text(
              'Información Personal',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF027A70),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextFormField(label: 'Nombres', hintText: ''),
            _buildTextFormField(label: 'Apellidos', hintText: ''),
            _buildTextFormField(label: 'Email', hintText: ''),
            _buildTextFormField(label: 'Contraseña', hintText: '', obscureText: true),
            _buildTextFormField(label: 'DUI', hintText: '', keyboardType: TextInputType.number),
            _buildTextFormField(label: 'Username', hintText: ''),
            _buildTextFormField(label: 'Teléfono', hintText: '', keyboardType: TextInputType.phone),
            _buildTextFormField(label: 'Dirección', hintText: ''),
            const SizedBox(height: 20),
            _buildDatePicker(context, 'Fecha Nacimiento'),
            const SizedBox(height: 20),
            _buildPhotoPicker(context, 'Agregar Foto'),
            const SizedBox(height: 20),
             _buildTextFormField(label: 'Fecha Creación', hintText: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()), readOnly: true), // Utiliza DateFormat para formatear la fecha y hora actual
            _buildTextFormField(label: 'Creado por', hintText: ''),
            const SizedBox(height: 20),
            _buildDropdownButton(context, 'Tipo de Permiso', ['Administrador', 'Usuario']),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  
                },
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

  Widget _buildTextFormField({required String label, required String hintText, TextInputType? keyboardType, bool obscureText = false, bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly, // Establece readOnly a true para que el campo no sea editable
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
      // Puedes hacer algo con la fecha seleccionada
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo, size: 30),
              SizedBox(width: 16),
              Text(
                'Seleccionar Foto',
                style: TextStyle(fontSize: 16),
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
  final pickedImage = await picker.getImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    // Aquí puedes hacer algo con la imagen seleccionada
  }
}

  Widget _buildDropdownButton(BuildContext context, String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: 'Administrador',
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
