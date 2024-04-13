import 'package:flutter/material.dart';
import 'my_drawer.dart';

class EditarUsuario extends StatelessWidget {
  const EditarUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuario'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black87,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 16.0),
              child: Text(
                'EDITAR USUARIO',
                style: TextStyle(
                  fontSize: 24,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Nombre de usuario:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nombre de Usuario',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'UID:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'UID',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Nombre:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nombre',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Apellido:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Apellido',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Tipo de Permiso:',
                    style: TextStyle(fontSize: 16),
                  ), 
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    items: <String>['Permiso1', 'Permiso2', 'Permiso3']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Dirección:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Dirección',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Fecha de Nacimiento:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Fecha Nacimiento',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Contraseña:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Email:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Teléfono:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Teléfono',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Estado:',
                    style: TextStyle(color: Color.fromARGB(69, 0, 0, 0)),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    items: <String>['Activo', 'Inactivo']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Fecha de Creación:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Fecha Creación',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Fecha de Actualización:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Fecha Actualización',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de Guardar
                    },
                    child: Text('Guardar'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de Eliminar
                    },
                    child: Text('Eliminar'),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Acción al presionar el botón de Regresar
                      Navigator.pop(context);
                    },
                    child: Text('Regresar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}