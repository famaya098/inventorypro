import 'package:flutter/material.dart';
import 'my_drawer.dart';
import 'productos_screen.dart'; // Importa la pantalla ProductosScreen
import 'editar_producto.dart'; // Importa la pantalla EditarProducto

class ListaProductosScreen extends StatelessWidget {
  const ListaProductosScreen({Key? key}) : super(key: key);

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
      body: CustomScrollView(
        slivers: [
          SliverPadding(
             padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'LISTA DE PRODUCTOS',
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
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Buscar producto',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón de buscar
                    },
                    child: Text('Buscar'),
                  ),
                  SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductosScreen()),
                      );
                    },
                    child: Text('Agregar'),
                  ),

                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Nombre del producto ${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Código: 12345'),
                      Text('Precio Compra: \$50.00'),
                      Text('Precio Venta: \$100.00'),
                      Text('Stock: 10 unidades'),
                      Text('Unidad: Libras'),
                    ],
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditarProducto()),
                      );
                    },
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: null, // Puedes quitar esta línea si no necesitas una acción
                    ),
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
