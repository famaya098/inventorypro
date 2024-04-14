import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_drawer.dart';

class AgregarTransac extends StatelessWidget {
  const AgregarTransac({Key? key});

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
        backgroundColor: const Color(0xFF027A70), 
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'VENTAS Y COMPRAS',
               style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF027A70),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextFormField(label: 'Código Transacción:', hintText: ''),
            const SizedBox(height: 20),
            _buildTextFormField(label: 'Fecha:', hintText: '', keyboardType: TextInputType.datetime),
            const SizedBox(height: 20),
            _buildDropdownButton(label: 'Medicamento:', items: ['Medicamento 1', 'Medicamento 2', 'Medicamento 3']),
            const SizedBox(height: 20),
            _buildTextFormField(label: 'Stock:', hintText: '', keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            _buildTextFormField(label: 'Cantidad de Ingreso o Salida:', hintText: '', keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            _buildDropdownButton(label: 'Tipo Transacción:', items: ['Entrada', 'Salida']),
            const SizedBox(height: 20),
            _buildTextFormField(label: 'Total Stock:', hintText: '', keyboardType: TextInputType.number),
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

  Widget _buildTextFormField({required String label, required String hintText, TextInputType? keyboardType}) {
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
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        DropdownButton<String>(
          isExpanded: true,
          underline: Container(
            height: 2,
            color: const Color(0xFF027A70),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white), 
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
