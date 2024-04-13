import 'package:flutter/material.dart';
import 'package:inventorypro/editar_usuario.dart';
import 'my_drawer.dart';

class ListaUsuariosScreen extends StatelessWidget {
  const ListaUsuariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
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
                  'LISTA DE USUARIOS',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Buscar usuario',
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
                // Información de los usuarios quemados
                List<Map<String, dynamic>> usuarios = [
                  {
                    'nombreUsuario': 'usuario1',
                    'uid': 'uid1',
                    'nombre': 'Nombre 1',
                    'apellido': 'Apellido 1',
                    'tipoPermiso': 'Permiso 1',
                    'direccion': 'Dirección 1',
                    'fechaNacimiento': 'Fecha de Nacimiento 1',
                    'contraseña': 'Contraseña 1',
                    'email': 'email1@example.com',
                    'telefono': 'Teléfono 1',
                    'status': 'Status 1',
                    'fechaCreacion': 'Fecha de Creación 1',
                    'fechaActualizacion': 'Fecha de Actualización 1',
                    'foto': 'ruta_de_la_foto_1',
                  },
                  {
                    'nombreUsuario': 'usuario2',
                    'uid': 'uid2',
                    'nombre': 'Nombre 2',
                    'apellido': 'Apellido 2',
                    'tipoPermiso': 'Permiso 2',
                    'direccion': 'Dirección 2',
                    'fechaNacimiento': 'Fecha de Nacimiento 2',
                    'contraseña': 'Contraseña 2',
                    'email': 'email2@example.com',
                    'telefono': 'Teléfono 2',
                    'status': 'Status 2',
                    'fechaCreacion': 'Fecha de Creación 2',
                    'fechaActualizacion': 'Fecha de Actualización 2',
                    'foto': 'ruta_de_la_foto_2',
                  },
                  {
                    'nombreUsuario': 'usuario3',
                    'uid': 'uid3',
                    'nombre': 'Nombre 3',
                    'apellido': 'Apellido 3',
                    'tipoPermiso': 'Permiso 3',
                    'direccion': 'Dirección 3',
                    'fechaNacimiento': 'Fecha de Nacimiento 3',
                    'contraseña': 'Contraseña 3',
                    'email': 'email3@example.com',
                    'telefono': 'Teléfono 3',
                    'status': 'Status 3',
                    'fechaCreacion': 'Fecha de Creación 3',
                    'fechaActualizacion': 'Fecha de Actualización 3',
                    'foto': 'ruta_de_la_foto_3',
                  },
                ];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(usuarios[index]['foto']),
                  ),
                  title: Text(usuarios[index]['nombreUsuario']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('UID: ${usuarios[index]['uid']}'),
                      Text('Nombre: ${usuarios[index]['nombre']} ${usuarios[index]['apellido']}'),
                      Text('Tipo de Permiso: ${usuarios[index]['tipoPermiso']}'),
                      Text('Dirección: ${usuarios[index]['direccion']}'),
                      Text('Fecha de Nacimiento: ${usuarios[index]['fechaNacimiento']}'),
                      Text('Contraseña: ${usuarios[index]['contraseña']}'),
                      Text('Email: ${usuarios[index]['email']}'),
                      Text('Teléfono: ${usuarios[index]['telefono']}'),
                      Text('Status: ${usuarios[index]['status']}'),
                      Text('Fecha de Creación: ${usuarios[index]['fechaCreacion']}'),
                      Text('Fecha de Actualización: ${usuarios[index]['fechaActualizacion']}'),
                      // Mostrar la foto del usuario
                    ],
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditarUsuario()),
                      );
                    },
                    child: const IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: null, // Puedes quitar esta línea si no necesitas una acción
                    ),
                  ),
                );
              },
              childCount: 3, // Mostrar tres usuarios quemados
            ),
          ),
        ],
      ),
    );
  }
}
