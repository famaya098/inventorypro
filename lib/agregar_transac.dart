import 'package:flutter/material.dart';
import 'my_drawer.dart';

class AgregarTransac extends StatelessWidget {
  const AgregarTransac({super.key});
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
              Text(
                'DATOS DE ENTRADA Y SALIDA DE MEDICAMENTOS',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: 20),
              Text(
                'Codigo Transacción:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Fecha:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '',
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 20),
              Text(
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
              SizedBox(height: 20),
              Text(
                'Stock:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Text(
                'Cantidad de Ingreso o Salida:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ingrese la cantidad de ingreso o salida',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Text(
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
              SizedBox(height: 20),
              Text(
                'Total Stock:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de guardar
                    },
                    child: Text('Guardar'),
                  ),
                  SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: () {
                      // Acción al presionar el botón de regresar
                      Navigator.pop(context);
                    },
                    child: Text('Regresar'),
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