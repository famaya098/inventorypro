import 'package:flutter/material.dart';
import 'my_drawer.dart';

class EditarProducto extends StatelessWidget {
  const EditarProducto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del producto'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Center(
              child: Text(
                'DATOS DEL PRODUCTO',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Codigo:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Codigo:'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Nombre:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nombre:'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Precio de compra:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Precio de Compra:'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Precio de venta:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Precio de Venta:'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Unidad:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Unidad:'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Stock:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Stock'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de guardar
                    },
                    child: Text('Guardar'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de eliminar
                    },
                    child: Text('Eliminar'),
                  ),
                 const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Acción al presionar el botón de regresar
                      Navigator.pop(context);
                    },
                    child: Text('Regresar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
