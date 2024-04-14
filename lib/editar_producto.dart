import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DATOS DEL PRODUCTO',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.blueAccent),
              ),
              const SizedBox(height: 20),
              _buildTextFormField(label: 'Codigo:', hintText: ''),
              const SizedBox(height: 20),
              _buildTextFormField(label: 'Nombre:', hintText: ''),
              const SizedBox(height: 20),
              _buildTextFormField(label: 'Precio de compra:', hintText: ''),
              const SizedBox(height: 20),
              _buildTextFormField(label: 'Precio de venta:', hintText: ''),
              const SizedBox(height: 20),
              _buildTextFormField(label: 'Unidad:', hintText: ''),
              const SizedBox(height: 20),
              _buildTextFormField(label: 'Stock:', hintText: ''),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Acción al presionar el botón de guardar
                },
                child: const Text('Guardar', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Acción al presionar el botón de eliminar
                },
                child: const Text('Eliminar', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blueAccent, 
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.blueAccent),
                  ),
                ),
                onPressed: () {
                  // Acción al presionar el botón de regresar
                  Navigator.pop(context);
                },
                child: const Text('Regresar', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({required String label, required String hintText}) {
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
        ),
      ],
    );
  }
}
