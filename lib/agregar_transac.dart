import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventorypro/productos_carrito.dart';
import 'my_drawer.dart';

class AgregarTransac extends StatelessWidget {
  const AgregarTransac({Key? key});

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
            Navigator.pop(context);
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
                'VENTAS Y COMPRAS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF027A70),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextFormField(
                label: 'Código Transacción:', hintText: ''),
            const SizedBox(height: 20),
            _buildTextFormField(
                label: 'Fecha:', hintText: '', keyboardType: TextInputType.datetime),
            const SizedBox(height: 20),
            _buildDropdownButton(
                label: 'Tipo Transacción:', items: ['Entrada', 'Salida']),
            const SizedBox(height: 20),
            // Campo de búsqueda de producto
           Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Navegar a la pantalla ProductosCarrito cuando se presiona el botón
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductosCarrito()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF027A70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.search),
                  label: const Text(
                    'Agregar Producto',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            // Fin del campo de búsqueda
            const SizedBox(height: 20),
            // Aquí incluimos el ListView.builder antes del botón "Guardar"
            Container(
              height: 300, // Altura del contenedor para la lista vertical
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 5, // Cambia este valor según la cantidad de elementos que desees mostrar
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[300],
                                  ),
                                  child: const Icon(Icons.image),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nombre del producto $index',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Precio unitario: \$10.00',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Precio total: \$10.00',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const Text(
                                        'Cantidad: 1',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Fin de la inserción del ListView.builder
            const SizedBox(height: 20),
            // Contenedor de precios...
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF027A70), // Color del botón "Guardar"
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Precio:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        '\$100.00',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Precio con IVA:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        '\$116.00',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Fin del contenedor de precios
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para guardar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF027A70),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      {required String label, required String hintText, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  Widget _buildDropdownButton({required String label, required List<String> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        DropdownButton<String>(
          isExpanded: true,
          underline: Container(
            height: 2,
            color: const Color(0xFF027A70),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          iconSize: 36,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AgregarTransac(),
  ));
}
