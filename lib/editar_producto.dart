import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_drawer.dart';

class EditarProducto extends StatelessWidget {
  const EditarProducto({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InventoryPro'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'DATOS DEL PRODUCTO',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF027A70),
                  ),
                ),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                     
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF027A70), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    icon: const Icon(Icons.save, size: 24, color: Colors.white),
                    label: const Text('Guardar', style: TextStyle(fontSize: 18, color: Colors.white)), 
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Acción al presionar el botón de eliminar
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    icon: const Icon(Icons.delete, size: 24, color: Colors.white), 
                    label: const Text('Eliminar', style: TextStyle(fontSize: 18, color: Colors.white)), 
                  ),
                ],
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
