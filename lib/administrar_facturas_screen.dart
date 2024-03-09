import 'package:flutter/material.dart';
import 'my_drawer.dart';

class AdminFacturasScreen extends StatelessWidget {
  const AdminFacturasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar Facturas'),
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
      body: const Center(
        child: Text('Contenido de la página Administrar Facturas'),
      ),
    );
  }
}
