import 'package:flutter/material.dart';
import 'my_drawer.dart';

class AgregarTransac extends StatelessWidget {
  const AgregarTransac({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Transacción'),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DATOS DE ENTRADA Y SALIDA DE MEDICAMENTOS',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 20),
              const Text(
                'Codigo Transacción:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Fecha:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '',
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 20),
              const Text(
                'Medicamento:',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                items: <String>['Medicamento 1', 'Medicamento 2', 'Medicamento 3']
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
                'Stock:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              const Text(
                'Cantidad de Ingreso o Salida:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Ingrese la cantidad de ingreso o salida',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              const Text(
                'Tipo Transacción:',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                items: <String>['Entrada', 'Salida']
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
                'Total Stock:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de guardar
                    },
                    child: const Text('Guardar'),
                  ),
                  const SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: () {
                      // Acción al presionar el botón de regresar
                      Navigator.pop(context);
                    },
                    child: const Text('Regresar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}