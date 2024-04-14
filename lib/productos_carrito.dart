import 'package:flutter/material.dart';
import 'package:inventorypro/agregar_transac.dart';
import 'my_drawer.dart'; 

class ProductosCarrito extends StatelessWidget {
  const ProductosCarrito({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Productos'),
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
                      Text('Precio Venta: \$100.00'),    
                      Text('Stock: 10 unidades'),                                          
                      
                    ],
                  ),
                  trailing: GestureDetector(
                    
                            child: const IconButton(
                      icon: Icon(Icons.local_grocery_store),
                      onPressed: null,
                           ),
                  ),
                );
              },
              childCount: 4, // Cambia esto según la cantidad de productos
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerRight,
              child: 
             OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AgregarTransac()),
                      );
                    },
                    child: const Text('Cerrar'),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}