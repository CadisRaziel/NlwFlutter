import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';


///regra de negocio do login
///aqui quando usuario clicar no botão para logar com o google
///ele vai verificar o login do usuario la no firebase
class LoginController {

  final authController = AuthController();

  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      ///repare que nesse final user eu não precisei atribuir o ! nos dois parametros, pois como ja tem no primeiro o proximo ja entende o !
      final user = UserModel(name: response!.displayName!, photoURL: response.photoUrl);
      authController.setUser(context, user);
      print(response);
    } catch (error) {
      authController.setUser(context, null);
      print(error);
    }
  }
}
///Observação importante: vale ressaltar que não estamos fazendo login no FIREBASE e sim usando o FIREBASE como uma ponte para o login google