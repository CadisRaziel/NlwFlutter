import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';


///regra de negocio do login
///aqui quando usuario clicar no botão para logar com o google
///ele vai verificar o login do usuario la no firebase
class LoginController {
  final authController = AuthController();
 

  GoogleSignIn _google = GoogleSignIn(
    scopes: [
      "email",
    ],
  );
  Future<void> googleSignIn(BuildContext context) async {
    try {
      final response = await _google.signIn();
      final user = UserModel(
        name: response!.displayName!,
        photoURL: response.photoUrl,
      );
      authController.setUser(context, user);
      print(response);
    } catch (e) {
      print(e);
    }
  }

  ///implementando logout <primeiro coloquei no auth_controller a função logOut()>
  Future<void> googleLogOut(BuildContext context) async {
    try {
      await _google.signOut();
      authController.logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } catch (e) {
      print(e);
    }
  }
}
///Observação importante: vale ressaltar que não estamos fazendo login no FIREBASE e sim usando o FIREBASE como uma ponte para o login google