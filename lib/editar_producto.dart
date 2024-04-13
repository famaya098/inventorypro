import 'package:flutter/material.dart';
import 'my_drawer.dart';

class EditarProducto extends StatelessWidget {
  const EditarProducto({super.key});

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
          const Padding(
            padding: EdgeInsets.only(top: 28.0),
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
                  const SizedBox(height: 20),
                  const Text(
                    'Codigo:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Codigo:'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nombre:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nombre:'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Precio de compra:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Precio de Compra:'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Precio de venta:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Precio de Venta:'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Unidad:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Unidad:'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Stock:',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Stock'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de guardar
                    },
                    child: const Text('Guardar'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de eliminar
                    },
                    child: const Text('Eliminar'),
                  ),
                 const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Acción al presionar el botón de regresar
                      Navigator.pop(context);
                    },
                    child: const Text('Regresar'),
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
