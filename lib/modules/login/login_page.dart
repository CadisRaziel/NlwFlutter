import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_style.dart';
import 'package:payflow/shared/widgets/loginButton/social_login_button.dart';

///Estamos fazendo essa tela de login com statefull pois teremos que gerenciar o botão do google
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ///vamos instanciar a classe do LoginController
  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    ///deixando o tamanho da parte laranja em % para se adequar nas telas diferentes

    ///Pegando o tamanho da tela com o MediaQuery
    ///utilizando o .size no final ele vai pegar o contexto da nossa tela atual !!
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        ///utilizamos esse container por cima do Stack por um motivo
        ///colocar width e height para que a imagem pegue toda a Stack e apareça inteira
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              ///utilizando o size (0.36 = 36%)
              width: size.width,
              height: size.height * 0.36,
              color: AppColors.primary,
            ),

            ///Vamos usar o positioned para alinhar a imagem person no centro da tela
            Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppImages.person,
                  width: 208,
                  height: 300,
                )),
            Positioned(
              ///utilizamos o bottom assim para ela se adequar nas telas de outros celulares
              bottom: size.height * 0.13,

              ///Coloque left e right 0 quando for trabalhar com mainAxis e crossAxis que nem abaixo
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logomini),

                  ///TextStyles = foi a classe que criamos dentro da pasta shared/themas/app_text_style
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 70, right: 70),
                    child: Text(
                      'Organize seus boletos em um só lugar',
                      style: TextStyles.titleHome,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  ///AnimatedCard para animar o botão de login do google
                  ///ao iniciar a tela ele vai ter um efeito de caindo
                  ///e com isso ele nao vai ser mais aquele botao statico de quando abre a tela ele ta la parado
                  AnimatedCard(
                    direction: AnimatedCardDirection.top,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 50),
                      child: SocialLoginButton(
                        ///e aqui no evento de clique colocamos a final controller com o metodo criado na classe LoginController
                        onTap: () {
                          controller.googleSignIn(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
