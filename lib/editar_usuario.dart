import 'package:flutter/material.dart';
import 'my_drawer.dart';

class EditarUsuario extends StatelessWidget {
  const EditarUsuario({super.key});

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
            const Padding(
              padding: EdgeInsets.only(top: 28.0, left: 16.0),
              child: Center(
                child: Text(
                  'EDITAR USUARIO',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Nombre de usuario:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Nombre de Usuario',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'UID:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'UID',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nombre:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Nombre',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Apellido:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Apellido',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
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
                  const SizedBox(height: 20),
                  const Text(
                    'Dirección:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Dirección',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Fecha de Nacimiento:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Fecha Nacimiento',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Contraseña:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Contraseña',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Email:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Teléfono:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Teléfono',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  const Text(
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
                  const SizedBox(height: 20),
                  const Text(
                    'Fecha de Creación:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Fecha Creación',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Fecha de Actualización:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Fecha Actualización',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de Guardar
                    },
                    child: const Text('Guardar'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de Eliminar
                    },
                    child: const Text('Eliminar'),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Acción al presionar el botón de Regresar
                      Navigator.pop(context);
                    },
                    child: const Text('Regresar'),
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