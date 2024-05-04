import 'dart:io'; // Importa la biblioteca dart:io
import 'package:path_provider/path_provider.dart'; // Importa la biblioteca path_provider

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:inventorypro/home_screen.dart';
import 'my_drawer.dart';
import 'producto.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
      home: ReporteInventarioScreen(),
    );
  }
}

class ReporteInventarioScreen extends StatefulWidget {
  const ReporteInventarioScreen({Key? key});

  @override
  _ReporteInventarioScreenState createState() => _ReporteInventarioScreenState();
}

class _ReporteInventarioScreenState extends State<ReporteInventarioScreen> {
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Reporte de Inventario',
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
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () async {
                    await _generatePdf(_productos);
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

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _productos.length,
                  itemBuilder: (BuildContext context, int index) {
                    var producto = _productos[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
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
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generatePdf(List<Producto> productos) async {
  final pdf = pw.Document();

  // Agregar el contenido al PDF
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: productos.map((producto) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Nombre del producto: ${producto.nombre}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Text('Código: ${producto.codigo}'),
                pw.Text('Precio Compra: \$${producto.precioCompra}'),
                pw.Text('Precio Venta: \$${producto.precioVenta}'),
                pw.Text('Stock: ${producto.cantidad} unidades'),
                pw.Text('Unidad: ${producto.unidad}'),
                pw.Text('Creado Por: ${producto.creadoPor} '),
                pw.Text('Estatus : ${producto.estatus} '),
                pw.SizedBox(height: 20),
              ],
            );
          }).toList(),
        );
      },
    ),
  );

  // Guardar el PDF en el almacenamiento externo
  final String dir = (await getExternalStorageDirectory())!.path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());
  print('PDF guardado en: $path');
}

}
