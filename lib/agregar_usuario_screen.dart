import 'package:flutter/material.dart';
import 'my_drawer.dart';

class AgregarUsuariosScreen extends StatelessWidget {
  const AgregarUsuariosScreen({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
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
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 28.0),
              child: Text(
                'REGISTRO USUARIO',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 0, 0, 0),
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
                'Email:',
                style: TextStyle(fontSize: 16),
              ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Correo Electrónico',
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
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
              const Text(
                'Nombre de Usuario:',
                style: TextStyle(fontSize: 16),
              ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Nombre de Usuario',
                    ),
                  ),
                  const SizedBox(height: 20),
              const Text(
                'Nombre:',
                style: TextStyle(fontSize: 16),
              ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Nombres',
                    ),
                  ),
                  const SizedBox(height: 20),
              const Text(
                'Apellido:',
                style: TextStyle(fontSize: 16),
              ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Apellidos',
                    ),
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
                'Fecha de Nacimiento:',
                style: TextStyle(fontSize: 16),
              ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Fecha de Nacimiento',
                    ),
                    keyboardType: TextInputType.datetime,
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
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Cargar Una Foto'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Registrar'),
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
