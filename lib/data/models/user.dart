// copyWith: Permite crear una copia de la instancia actual de User, pero cambiando solo los valores que necesites.
// Esto es útil si quieres actualizar algunos campos sin modificar la instancia original del objeto.
// Ejemplo: Si tienes un usuario con email 'juan@example.com' y quieres cambiarlo a 'nuevo@example.com', usas copyWith para crear una copia con solo ese campo modificado.
// Cuando llamas copyWith, las propiedades que no especifiques mantendrán los valores de la instancia original.

// toMap: Convierte la instancia del objeto User en un Map<String, dynamic>.
// Esto es útil para guardar el objeto User en una base de datos o para enviarlo a través de una API.
// Ejemplo: Convierte tu usuario a algo como {"id": 1, "username": "juan", "email": "juan@example.com"}.
// El mapa resultante es un formato fácil de trabajar cuando necesitas manejar datos de forma estructurada.

// fromMap: Es un constructor de fábrica que crea una instancia de User a partir de un Map<String, dynamic>.
// Utiliza este método cuando recibes datos desde una fuente externa (como una base de datos o una API) y quieres convertir esos datos en un objeto User.

// toJson: Convierte la instancia del objeto User en un String JSON.
// JSON es un formato de texto que es ampliamente utilizado para enviar y recibir datos en aplicaciones web.
// Ejemplo: {"id":1,"username":"juan","email":"juan@example.com"}.
// Es útil para serializar tu objeto User y enviarlo a través de internet o almacenarlo de manera legible.

// fromJson: Otro constructor de fábrica que convierte un String JSON en una instancia de User.
// Usa este método cuando recibas datos JSON de una API o un archivo y necesites trabajar con ellos como un objeto User en tu aplicación.

// toString: Devuelve una representación en String de la instancia User. Es una forma de ver todos los valores de un usuario de manera clara y legible.
// Ejemplo de resultado: User(id: 1, username: juan, email: juan@example.com).
// Esto es especialmente útil para la depuración (debugging) y para entender el estado actual de una instancia User durante la ejecución del programa.

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  User copyWith({
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
    String? accessToken,
    String? refreshToken,
  }) {
    return User(
      id: id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'image': image,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      username: map['username'] as String,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      gender: map['gender'] as String,
      image: map['image'] as String,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, firstName: $firstName, lastName: $lastName, gender: $gender, image: $image, accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}
