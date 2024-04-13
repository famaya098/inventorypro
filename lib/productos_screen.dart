import 'package:flutter/material.dart';
import 'my_drawer.dart';

class ProductosScreen extends StatelessWidget {
  const ProductosScreen({Key? key}) : super(key: key);

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
              Center(
                child: Text(
                  'AGREGAR PRODUCTOS',
                  style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Codigo:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Nombre:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ingrese el nombre del medicamento',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Precio de Compra:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '\$: ',
                  prefixText: '\$:',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Text(
                'Precio de Venta:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '\$:',
                  prefixText: '\$:',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Text(
                'Unidad:',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                items: <String>['Unidad 1', 'Unidad 2', 'Unidad 3']
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
                'Cantidad de Unidades que Ingresa:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ingrese la cantidad de unidades',
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
