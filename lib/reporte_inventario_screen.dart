import 'package:flutter/material.dart';
import 'my_drawer.dart';

class ReporteInventarioScreen extends StatelessWidget {
  const ReporteInventarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte Inventario'),
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
      body: CustomScrollView(
        slivers: [
          const SliverPadding(
             padding: EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'REPORTE DE INVENTARIO',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            )
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Buscar producto',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de buscar
                    },
                    child: const Text('Buscar'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton( onPressed: () {
                      // Acción al presionar el botón de buscar
                    },                   
                    child: const Text('Imprimir'),
                  ),

                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Nombre del producto ${index + 1}'),
                  subtitle: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Código: 12345'),
                      Text('Precio Compra: \$50.00'),
                      Text('Precio Venta: \$100.00'),
                      Text('Stock: 10 unidades'),
                      Text('Unidad: Libras'),
                    ],
                  ),                
                );
              },
              childCount: 2, // Cambia esto según la cantidad de productos
            ),
          ),
        ],
      ),
    );
  }
}
