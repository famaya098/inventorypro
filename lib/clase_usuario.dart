//clase_usuario

class Usuario {
    final String id;
    final String nombres;
    final String apellidos;
    final String fechaNacimiento;
    final String telefono;
    final String tipoPermiso;
    final String direccion;
    final String dui;
    final String email;
    final String contrasena;
    final String creadoPor;
    final String fechaCreacion;
    final String fotoUrl;
    final String username;

    Usuario({
        required this.id,
        required this.nombres,
        required this.apellidos,
        required this.fechaNacimiento,
        required this.telefono,
        required this.tipoPermiso,
        required this.direccion,
        required this.dui,
        required this.email,
        required this.contrasena,
        required this.creadoPor,
        required this.fechaCreacion,
        required this.fotoUrl,
        required this.username,
    });

    Map<String, dynamic> toMap() {
        return {
            'uid': id,
            'nombres': nombres,
            'apellidos': apellidos,
            'fechaNacimiento': fechaNacimiento,
            'telefono': telefono,
            'tipoPermiso': tipoPermiso,
            'direccion': direccion,
            'dui': dui,
            'email': email,
            'contrasena': contrasena,
            'creadoPor': creadoPor,
            'fechaCreacion': fechaCreacion,
            'fotoUrl': fotoUrl,
            'username': username,
        };
    }

    factory Usuario.fromMap(String id, Map<String, dynamic> map) {
        return Usuario(
            id: map['uid'] ?? '',
            nombres: map['nombres'] ?? '',
            apellidos: map['apellidos'] ?? '',
            fechaNacimiento: map['fechaNacimiento'] ?? '',
            telefono: map['telefono'] ?? '',
            tipoPermiso: map['tipoPermiso'] ?? '',
            direccion: map['direccion'] ?? '',
            dui: map['dui'] ?? '',
            email: map['email'] ?? '',
            contrasena: map['contrasena'] ?? '',
            creadoPor: map['creadoPor'] ?? '',
            fechaCreacion: map['fechaCreacion'] ?? '',
            fotoUrl: map['fotoUrl'] ?? '',
            username: map['username'] ?? '',
        );
    }
}
