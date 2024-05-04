import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventorypro/home_screen.dart';
import 'package:inventorypro/editar_usuario.dart';
import 'my_drawer.dart';
import 'clase_usuario.dart';

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
      home: ReporteUsuariosScreen(),
    );
  }
}

class ReporteUsuariosScreen extends StatefulWidget {
  const ReporteUsuariosScreen({Key? key});

  @override
  _ReporteUsuariosScreenState createState() => _ReporteUsuariosScreenState();
}

class _ReporteUsuariosScreenState extends State<ReporteUsuariosScreen> {
  String _searchQuery = '';
  List<Usuario> _usuarios = [];

  List<Usuario> _filteredUsuarios() {
    return _usuarios.where((usuario) {
      return usuario.nombres.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.apellidos.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.contrasena.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.creadoPor.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.direccion.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.dui.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.fechaCreacion.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.fechaNacimiento.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.telefono.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.tipoPermiso.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          usuario.username.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

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
                'Lista de Usuarios',
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
                        hintText: 'Buscar usuario',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    setState(() {});
                  },
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
                  .child('usuarios')
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
                Map<dynamic, dynamic> usuariosData =
                    snapshot.data!.value as Map<dynamic, dynamic>;
                _usuarios = usuariosData.entries
                    .map((entry) => Usuario.fromMap(
                        entry.key.toString(),
                        Map<String, dynamic>.from(entry.value)))
                    .toList();

                // Filtrar usuarios después de obtener datos de Firebase
                _usuarios = _filteredUsuarios();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _usuarios.length,
                  itemBuilder: (BuildContext context, int index) {
                    var usuario = _usuarios[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(usuario.fotoUrl),
                        ),
                        title: Text(
                          '${usuario.nombres} ${usuario.apellidos}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fecha de Nacimiento: ${usuario.fechaNacimiento}'),
                            Text('Teléfono: ${usuario.telefono}'),
                            Text('Tipo de Permiso: ${usuario.tipoPermiso}'),
                            Text('Dirección: ${usuario.direccion}'),
                            Text('DUI: ${usuario.dui}'),
                            Text('Email: ${usuario.email}'),
                            Text('Creado por: ${usuario.creadoPor}'),
                            Text('Fecha de Creación: ${usuario.fechaCreacion}'),
                            Text('UserName: ${usuario.username}'),
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
                                  MaterialPageRoute(builder: (context) => EditarUsuario()),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // Guardar el índice antes de mostrar el diálogo de confirmación
                                int selectedIndex = index;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirmar eliminación'),
                                      content: const Text('¿Está seguro de que desea eliminar este usuario?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Llamar al método de eliminación con el índice guardado
                                            _deleteUsuario(selectedIndex);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Sí'),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteUsuario(int index) {
    // Obtener el usuario correspondiente al índice
    var usuario = _usuarios[index];
    print('Eliminando usuario: ${usuario.id}');
    // Eliminar el usuario de Firebase
    FirebaseDatabase.instance.reference().child('usuarios').child(usuario.id).remove().then((_) {
      print('Usuario eliminado de Firebase');
      // Eliminar el usuario de la lista local después de eliminarlo de Firebase
      setState(() {
        _usuarios.removeAt(index);
      });
      Fluttertoast.showToast(
        msg: 'Usuario eliminado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }).catchError((error) {
      print('Error al eliminar usuario de Firebase: $error');
      Fluttertoast.showToast(
        msg: 'Error al eliminar usuario',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }
}
