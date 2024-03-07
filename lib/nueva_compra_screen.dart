import 'package:flutter/material.dart';

class NuevaCompraScreen extends StatelessWidget {
  const NuevaCompraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Compra'),
      ),
      body: const Center(
        child: Text('Contenido de la página Nueva Compra'),
      ),
    );
  }
}
