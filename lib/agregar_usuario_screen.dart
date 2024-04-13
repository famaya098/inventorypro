import 'package:flutter/material.dart';
import 'my_drawer.dart';

class AgregarUsuariosScreen extends StatelessWidget {
  const AgregarUsuariosScreen({Key? key}) : super(key: key);

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
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
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
                  SizedBox(height: 20),
              Text(
                'Email:',
                style: TextStyle(fontSize: 16),
              ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Correo Electrónico',
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
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
              Text(
                'Nombre de Usuario:',
                style: TextStyle(fontSize: 16),
              ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nombre de Usuario',
                    ),
                  ),
                  SizedBox(height: 20),
              Text(
                'Nombre:',
                style: TextStyle(fontSize: 16),
              ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nombres',
                    ),
                  ),
                  SizedBox(height: 20),
              Text(
                'Apellido:',
                style: TextStyle(fontSize: 16),
              ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Apellidos',
                    ),
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
                'Teléfono:',
                style: TextStyle(fontSize: 16),
              ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Teléfono',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),
              Text(
                'Fecha de Nacimiento:',
                style: TextStyle(fontSize: 16),
              ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Fecha de Nacimiento',
                    ),
                    keyboardType: TextInputType.datetime,
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
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Cargar Una Foto'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Registrar'),
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
