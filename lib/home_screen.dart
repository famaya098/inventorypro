import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventorypro/agregar_transac.dart';
import 'package:inventorypro/reporte_inventario_screen.dart';
import 'package:inventorypro/reporte_transac.dart';

import 'my_drawer.dart';
import 'productos_screen.dart'; 

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(fontFamily: 'Roboto'),
  home: const HomeScreen(),
));

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text('', style: TextStyle(color: Colors.black)),
      ),
      drawer: const MyDrawer(),
      //endDrawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30))),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Hola, Freddy!',
                    style: TextStyle(color: Colors.black87, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(244, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: const TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black87,
                          ),
                          hintText: "¡Busca lo que necesites!",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Accesos directos',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      promoCard(
                          'assets/images/caja.png', 'Agregar Productos', () {
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ProductosScreen()),
                            );
                          }),
                      promoCard('assets/images/transaccion.png',
                              'Realizar Transacción', () {
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                const agregarTransac = AgregarTransac();
                                return agregarTransac;
                              }),
                            );
                          }),
                      promoCard('assets/images/inven.jpg', 'Reporte Stock',  () {
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                const agregarTransac = ReporteInventarioScreen();
                                return agregarTransac;
                              }),
                            );
                          }),
                      promoCard('assets/images/carpeta.png',
                              'Reporte Transacción',() {
                           
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                const agregarTransac = ReporteTransac();
                                return agregarTransac;
                              }),
                            );
                            }),
                            
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget promoCard(String image, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, stops: const [
                0.1,
                0.9
              ], colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.1)
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTap() {
    
  }
}
