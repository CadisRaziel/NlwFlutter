import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/modules/barcode_scaneer/barcode_scanner_page.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/splash/spash_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';

class AppWidget extends StatelessWidget {
  ///resumindo ABRIR A TELA COM A ROTAÇÃO DE 90 GRAUS
  ///como funciona, quando clicamos no botão para abrir o scanner,ele abre a tela em pé, em seguida vai virar a tela e depois abrir o layout
  ///e isso pode dar bug, travar o celular
  ///com essa opção abaixo ao clicar no botão para scanner ele ja vai abrir a tela deitada com o layout pronto
  ///ou seja os Widget's que tem o RotatedBox sera afetado por esse constructor !
  // AppWidget() {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitDown,
  //     DeviceOrientation.portraitUp,
  //   ]);
  // }]

  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

          ///primarySwatch = quando clicarmos no botão ele vai dar um efeito de click laranja !!!
          primarySwatch: Colors.orange,

          ///utilizamos primaryColor pois o Color é do mateialApp
          primaryColor: AppColors.primary),
      title: 'PayFlow',

      ///Rotas nomeadas
      initialRoute: "/splash",
      routes: {
        ///user: ModalRoute.of(context)!.settings.arguments as UserModel) quando o usaurio fizer login vai aparecer os dados dele !!
        "/splash": (context) => SplashPage(),
        "/home": (context) => HomePage(
            user: ModalRoute.of(context)!.settings.arguments as UserModel),
        "/login": (context) => LoginPage(
              controller: controller,
            ),
        "/barcode_scanner": (context) => BarcodeScannerPage(),
        "/insert_boleto": (context) => InsertBoletoPage(
              barcode: ModalRoute.of(context) != null
                  ? ModalRoute.of(context)!.settings.arguments.toString()
                  : null,
            )
      },
    );
  }
}

//rotas nomeadas com const
/*
 onGenerateRoute: (settings) {
        late Widget page;
        if (settings.name == routeSplash) {
          page = SplashPage();
        } else if (settings.name == routeLogin) {
          page = LoginPage();
        } else if (settings.name == routeHome) {
          page = HomePage();
        } else {
          throw Exception('Rota desconhecida: ${settings.name}');
        }

        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return page;
          },
          settings: settings,
        );
      },
      */
