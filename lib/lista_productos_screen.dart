import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_drawer.dart';
import 'productos_screen.dart'; // Importa la pantalla ProductosScreen
import 'editar_producto.dart'; // Importa la pantalla EditarProducto
import 'home_screen.dart'; // Importa la pantalla HomeScreen

class ListaProductosScreen extends StatelessWidget {
  const ListaProductosScreen({Key? key});

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
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
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'LISTA DE PRODUCTOS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF027A70),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Buscar producto',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      // Acción al presionar el botón de imprimir
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF027A70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.print, size: 24, color: Colors.white),
                    label: const Text(
                      'Imprimir',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
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
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditarProducto()),
                      );
                    },
                    child: const IconButton(
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
