//ReporteTransac

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'Transaccion.dart';
import 'my_drawer.dart';
import 'home_screen.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReporteTransac extends StatefulWidget {
  const ReporteTransac({Key? key}) : super(key: key);

  @override
  _ReporteTransacState createState() => _ReporteTransacState();
}

class _ReporteTransacState extends State<ReporteTransac> {
  String _searchQuery = '';
  List<Transaccion> _transacciones = [];

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
                'REPORTE TRANSACCIONES',
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
                        hintText: 'Buscar transacción',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
    _generatePdf(_transacciones);
  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF027A70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.print, size: 24, color: Colors.white),
                  label: const Text(
                    'PDF',
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
                  .child('transaccion_producto')
                  .onValue
                  .map((event) => event.snapshot),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.value == null) {
                  return const Text('No hay datos disponibles');
                }
                Map<dynamic, dynamic> transaccionesData =
                    snapshot.data!.value as Map<dynamic, dynamic>;
                _transacciones = transaccionesData.entries
                    .map((entry) => Transaccion.fromMap(
                        entry.key.toString(),
                        Map<String, dynamic>.from(entry.value)))
                    .toList();

                _transacciones = _transacciones.where((transaccion) {
                  return transaccion.nombreProducto
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()) ||
                      transaccion.codigoTransaccion
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase());
                }).toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _transacciones.length,
                  itemBuilder: (BuildContext context, int index) {
                    var transaccion = _transacciones[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          transaccion.nombreProducto,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Código Transacción: ${transaccion.codigoTransaccion}'),
                            Text('Fecha: ${transaccion.fechaTransaccion}'),
                            Text(
                                'Tipo de transacción: ${transaccion.tipoTransaccion}'),
                            Text(
                                'Cantidad Ingresada: ${transaccion.cantidadIngresada}'),
                            Text('Stock Inicial: ${transaccion.stockInicial}'),
                            Text('Stock Final: ${transaccion.stockFinal}'),
                            Text('Creado Por: ${transaccion.creadoPor}'),
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

  Future<void> _generatePdf(List<Transaccion> transacciones) async {
    final pdf = pw.Document();

    // Agregar el contenido al PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: transacciones.map((transaccion) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Nombre del producto: ${transaccion.nombreProducto}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                      'Código Transacción: ${transaccion.codigoTransaccion}'),
                  pw.Text('Fecha: ${transaccion.fechaTransaccion}'),
                  pw.Text(
                      'Tipo de transacción: ${transaccion.tipoTransaccion}'),
                  pw.Text(
                      'Cantidad Ingresada: ${transaccion.cantidadIngresada}'),
                  pw.Text('Stock Inicial: ${transaccion.stockInicial}'),
                  pw.Text('Stock Final: ${transaccion.stockFinal}'),
                  pw.Text('Creado Por: ${transaccion.creadoPor}'),
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
    final String path = '$dir/report_transacciones.pdf';
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());
    print('PDF guardado en: $path');

    // Mostrar SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reporte Transacciones PDF generado con exito'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }
}