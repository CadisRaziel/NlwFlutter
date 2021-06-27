import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Colocamos o auth dentro da pasta shared pois de qualquer lugar do app podemos chama-la para ver se o usuario ta logado ou nao
///ou podemos usar para pegar os dados do usuario e salva-los

class AuthController {
  ///essa variavel abaixo vai verificar se esta autenticado ou não
  ///depois de configuarmos toda authenticação pelo sharedPreference podemos tirar essa variavel !
  // var _isAuthenticated = false;

  ///antes era var agora é UserModel para evitar erro(esta descrito la na classe UserModel)
  UserModel? _user;

  ///para ninguem alterar o user
  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    ///se o usuario for diferente de nullo vai salvar a autenticação
    if (user != null) {
      saveUser(user);
      _user = user;
      // _isAuthenticated = true;
      ////pushReplacement = para nao ter um icone de voltar !
      Navigator.pushReplacementNamed(context, "/home", arguments: user);

      ///se ele for nulo continua false
    } else {
      // _isAuthenticated = false;
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  ///SharedPreference é usado para salvar dados do usuario como: login, foto, senha etc..
  ///para isso adicione o shared_preferences no pubspec
  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
    return;
  }

  ///Essa função currentUser é para ser usada na SplashPage para:
  ///se o usuario ja existir ele vai para a home
  ///se nao existir usuario ele vai ir para tela de login
  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();

    ///aqui colocamos o delay que iria na splashScreen
    await Future.delayed(Duration(seconds: 3));

    ///repare que o get não precisamos do await pois para buscar não precisa!
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      setUser(context, UserModel.fromJson(json));
    return;
    } else {
      setUser(context, null);
    }
  }

  ///Implementando logout
   Future<void> logOut() async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove("user");
  }
}
