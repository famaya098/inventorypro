import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_drawer.dart';

class ProductosScreen extends StatelessWidget {
  const ProductosScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
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
              padding: const EdgeInsets.only(left: 16),
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
                'AGREGAR PRODUCTOS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextFormField(label: 'Codigo:', hintText: ''),
              const SizedBox(height: 20),
              _buildTextFormField(label: 'Nombre:', hintText: ''),
              const SizedBox(height: 20),
              _buildTextFormField(label: 'Precio de Compra:', hintText: '', prefixText: '\$ '),
              const SizedBox(height: 20),
              _buildTextFormField(label: 'Precio de Venta:', hintText: '', prefixText: '\$ '),
              const SizedBox(height: 20),
              _buildDropdownButton(label: 'Unidad:', items: ['Unidad 1', 'Unidad 2', 'Unidad 3']),
              const SizedBox(height: 20),
              _buildTextFormField(label: 'Cantidad de Unidades que Ingresa:', hintText: ''),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Acción al presionar el botón de guardar
                    },
                    child: const Text(
                      'Guardar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 20),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blueAccent, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: BorderSide(color: Colors.blueAccent),
                    ),
                    onPressed: () {
                      // Acción al presionar el botón de regresar
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Regresar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({required String label, required String hintText, String prefixText = ''}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hintText,
            prefixText: prefixText,
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildDropdownButton({required String label, required List<String> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        DropdownButton<String>(
          isExpanded: true,
          underline: Container(
            height: 2,
            color: Colors.blueAccent,
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white), // Cambiamos el color del icono
          iconSize: 36,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        ),
      ],
    );
  }
}
