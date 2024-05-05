import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:inventorypro/editar_producto.dart';
import 'package:inventorypro/home_screen.dart';
import 'my_drawer.dart';
import 'producto.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InventoryPro',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ListaProductos(),
    );
  }
}

class ListaProductos extends StatefulWidget {
  const ListaProductos({Key? key});

  @override
  _ListaProductosState createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  String _searchQuery = '';
  List<Producto> _productos = [];

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
        backgroundColor: const Color(0xFF027A70),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Lista de Productos',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF027A70),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Buscar producto',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF027A70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.search, size: 24, color: Colors.white),
                  label: const Text(
                    '',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey),
            StreamBuilder<DataSnapshot>(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child('productos')
                  .onValue
                  .map((event) => event.snapshot),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.value == null) {
                  return Text('No hay datos disponibles');
                }
                Map<dynamic, dynamic> productosData =
                    snapshot.data!.value as Map<dynamic, dynamic>;
                _productos = productosData.entries
                    .map((entry) => Producto.fromMap(
                        entry.key.toString(),
                        Map<String, dynamic>.from(entry.value)))
                    .toList();

                _productos = _productos.where((producto) {
                  return producto.nombre.toLowerCase().contains(_searchQuery.toLowerCase());
                }).toList();

                return SizedBox(
                  height: MediaQuery.of(context).size.height - 260, // Ajusta esta altura según sea necesario
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _productos.length,
                    itemBuilder: (BuildContext context, int index) {
                      var producto = _productos[index];
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          leading: Image.network(producto.fotoUrl),
                          title: Text(
                            producto.nombre,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Stock: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${producto.cantidad} unidades',
                                    style: TextStyle(
                                      color: producto.cantidad > 0 ? Color(0xFF027A70) : Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Text('Código: ${producto.codigo}'),
                              Text('Precio Compra: \$${producto.precioCompra}'),
                              Text('Precio Venta: \$${producto.precioVenta}'),
                              Text('Unidad: ${producto.unidad}'),
                              Text('Creado Por: ${producto.creadoPor} '),
                              Text('Estatus : ${producto.estatus} '),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditarProducto(
                                        productId: producto.id,
                                        productData: {
                                          'nombre': producto.nombre,
                                          'descripcion': producto.descripcion,
                                          'precioCompra': producto.precioCompra,
                                          'precioVenta': producto.precioVenta,
                                          'cantidad': producto.cantidad,
                                          'unidad': producto.unidad,
                                          'estatus': producto.estatus,
                                          'fotoUrl': producto.fotoUrl,
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirmar Eliminación'),
                                        content: const Text('¿Está seguro de que desea eliminar este producto?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _eliminarProducto(producto);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Eliminar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _eliminarProducto(Producto producto) {
    FirebaseDatabase.instance
        .reference()
        .child('productos')
        .child(producto.id)
        .remove();

    setState(() {
      _productos.removeWhere((p) => p.id == producto.id);
    });
  }
}