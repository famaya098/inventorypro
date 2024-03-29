import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventorypro/administrar_facturas_screen.dart';
import 'package:inventorypro/agregar_usuario_screen.dart';
import 'package:inventorypro/clientes_screen.dart';
import 'package:inventorypro/fabricantes_screen.dart';
import 'package:inventorypro/historial_screen.dart';
import 'package:inventorypro/home_screen.dart';
import 'package:inventorypro/impuestos_screen.dart';
import 'package:inventorypro/login_page.dart';
import 'package:inventorypro/nueva_compra_screen.dart';
import 'package:inventorypro/nueva_venta_screen.dart';
import 'package:inventorypro/perfil_empresa_screen.dart';
import 'package:inventorypro/productos_screen.dart';
import 'package:inventorypro/profile_screen.dart';
import 'package:inventorypro/proveedores_screen.dart';
import 'package:inventorypro/reporte_inventario_screen.dart';
import 'package:inventorypro/reporte_kardex_screen.dart';
import 'package:inventorypro/reporte_utilidades_screen.dart';
import 'package:inventorypro/reporte_ventas_screen%20copy.dart';
import 'package:inventorypro/reporte_compras_screen.dart';
import 'package:inventorypro/text_icon_button.dart';
import 'package:inventorypro/usuarios_screen.dart';


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
                
                ExpansionTile(
                  leading: const Icon(Icons.shopping_cart_outlined),
                  title: const Text('Compras'),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add_circle_outline_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const NuevaCompraScreen(),
                          ),
                        );
                      },
                      title: const Text('Nueva Compra'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.history_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const HistorialScreen(),
                          ),
                        );
                      },
                      title: const Text('Historial Compras'),
                    ),
                  ],
                ),



                 TextIconButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const ProductosScreen(),
                    ),
                  ),
                  icon: Icons.inventory_outlined,
                  label: 'Productos',
                ),
                

                TextIconButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const FabricantesScreen(),
                    ),
                  ),
                  icon: Icons.precision_manufacturing_outlined,
                  label: 'Fabricantes',
                ),
                



                ExpansionTile(
                  leading: const Icon(Icons.perm_contact_calendar_outlined),
                  title: const Text('Contactos'),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.groups_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ClientesScreen(),
                          ),
                        );
                      },
                      title: const Text('Clientes'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.engineering_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ProveedoresScreen(),
                          ),
                        );
                      },
                      title: const Text('Proveedores'),
                    ),
                  ],
                ),



                ExpansionTile(
                  leading: const Icon(Icons.real_estate_agent_outlined),
                  title: const Text('Facturación'),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add_circle_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const NuevaVentaScreen(),
                          ),
                        );
                      },
                      title: const Text('Nueva Venta'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.summarize_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const AdminFacturasScreen(),
                          ),
                        );
                      },
                      title: const Text('Administrar Facturas'),
                    ),
                  ],
                ),



                ExpansionTile(
                  leading: const Icon(Icons.summarize_outlined),
                  title: const Text('Reportes'),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.note_add_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ReporteVentasScreen(),
                          ),
                        );
                      },
                      title: const Text('Ventas'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.description_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ReporteComprasScreen(),
                          ),
                        );
                      },
                      title: const Text('Compras'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.file_open_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ReporteInventarioScreen(),
                          ),
                        );
                      },
                      title: const Text('Inventario'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.post_add_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ReporteUtilidadesScreen(),
                          ),
                        );
                      },
                      title: const Text('Utilidades'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.article_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ReporteKardexScreen(),
                          ),
                        );
                      },
                      title: const Text('Kardex'),
                    ),
                  ],
                ),



                ExpansionTile(
                  leading: const Icon(Icons.vpn_key_outlined),
                  title: const Text('Accesos'),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.people_alt_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const UsuariosScreen(),
                          ),
                        );
                      },
                      title: const Text('Usuarios'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.add_circle_outline_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const AgregarUsuariosScreen(),
                          ),
                        );
                      },
                      title: const Text('Agregar Usuario'),
                    ),
                  ],
                ),


                ExpansionTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Configuracion'),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.factory_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const PerfilEmpresaScreen(),
                          ),
                        );
                      },
                      title: const Text('Perfil de la Empresa'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.paid_outlined),
                      onTap: () {
                        Navigator.of(context).pop(); // Cierra el menú
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const ImpuestosScreen(),
                          ),
                        );
                      },
                      title: const Text('Impuestos'),
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
