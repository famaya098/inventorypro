import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventorypro/agregar_usuario_screen.dart';
import 'package:inventorypro/lista_usuarios.dart';

import 'package:inventorypro/home_screen.dart';

import 'package:inventorypro/login_page.dart';
import 'package:inventorypro/lista_productos_screen.dart';

import 'package:inventorypro/profile_screen.dart';

import 'package:inventorypro/reporte_ventas_screen%20copy.dart';
import 'package:inventorypro/reporte_compras_screen.dart';
import 'package:inventorypro/text_icon_button.dart';



class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              ),
              child: buildHeader(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                TextIconButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  ),
                  icon: Icons.home_outlined,
                  label: 'Inicio',
                ),
                
                TextIconButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const ListaProductosScreen(),
                    ),
                  ),
                  icon: Icons.inventory_outlined,
                  label: 'Productos',
                ),

                TextIconButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  ),
                  icon: Icons.compare_arrows,
                  label: 'Transacciones',
                ),
                
 ExpansionTile(
                  leading: const Icon(Icons.folder),
                  title: const Text('Reportes'),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.description),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ReporteVentasScreen(),
                          ),
                        );
                      },
                      title: const Text('Transacciones'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ReporteComprasScreen(),
                          ),
                        );
                      },
                      title: const Text('Stock'),
                    ),
                                        
                  ],
                ),
                

                ExpansionTile(
                  leading: const Icon(Icons.contacts),
                  title: const Text('Administrar Usuarios'),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.local_library),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ListaUsuariosScreen(),
                          ),
                        );
                      },
                      title: const Text('Ver usuarios'),
                    ),
                          ListTile(
                      leading: const Icon(Icons.person_add),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const AgregarUsuariosScreen(),
                          ),
                        );
                      },
                      title: const Text('Agregar usuarios'),
                    ),                              
                  ],
                ),
                

    






                const Divider(
                  height: 50,
                  color: Colors.black,
                  thickness: 1,
                ),
                
                TextIconButton(
                  onPressed: () {
                    
                    Navigator.of(context).pop();

                  
                    Fluttertoast.showToast(
                      msg: "Sesión cerrada",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                    
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(title: '',), 
                      ),
                      (route) => false,
                    );
                  },
                  icon: Icons.logout,
                  label: 'Log Out',
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }
}

Widget buildHeader() => InkWell(
      child: Container(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 20,
        ),
        color: const Color(0xff177272),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/perfil3.jpg'),
            ),
            SizedBox(height: 15),
            Text(
              'Freddy Amaya',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Colors.white),
                Text(
                  'San Salvador',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
