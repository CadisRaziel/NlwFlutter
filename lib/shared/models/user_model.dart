import 'dart:convert';
///classe criada para não der erro na função saveUser() pois la o parametro esta como var ou seja pode vir qualquer coisa(int, bool, string)
///porém o await instance.setString("user", user); RECEBE SÒMENTE STRING !!!!!
///por isso vamos criar essa classe abaixo para evitar esse erro

class UserModel {
  final String name;

  ///a foto pode ser nula porque as vezes o usuario não tem foto
  final String? photoURL;

  UserModel({required this.name, this.photoURL});

  ///conversão de String para um Map para usar em auth_controller currentUser()
  ///Lembre-se a factory fica antes do map abaixo
  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(name: map['name'], photoURL: map['photoURL']);
  }

  ///como eu coloquei 'as String' la no currentUser eu preciso fazer o map acima, e depois converter para string aqui
  factory UserModel.fromJson(String json) => UserModel.fromMap(jsonDecode(json));

  ///Esse map e o toJson foi criado para podermos converter o user para string em auth_controller
  Map<String, dynamic> toMap() => {
    "name": name,
    "photoURL": photoURL
  };

  ///vai transformar nosso toMap em String para ser usado em auth_controller saveUser()
  String toJson() => jsonEncode(toMap());

  
}