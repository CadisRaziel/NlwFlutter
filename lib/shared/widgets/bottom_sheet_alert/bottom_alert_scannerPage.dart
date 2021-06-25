import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_style.dart';
import 'package:payflow/shared/widgets/BottonNAV_Widget_buttons_scannerPage/set_label_buttons.dart';

///Alerta criado para aparecer um container notificando o usuario que nao foi possivel ler o codigo de barras caso der erro
class BottomSheetWidget extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secundaryLabel;
  final VoidCallback secundaryOnPressed;
  final String title;
  final String subTitle;

  const BottomSheetWidget({
    Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secundaryLabel,
    required this.secundaryOnPressed,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Material = para nao ficar aquele texto com duas linhas vermelhas embaixo
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: RotatedBox(
        quarterTurns: 1,
        child: Material(
          child: Container(
            color: AppColors.shape,

            ///Repare que colocamos uma Column em cima da outra
            ///o motivo é que quand o alerta desse Column abaixo aparecer (pois é um erro de escannear o boleto ou digitar o codigo)
            ///ele vai ser apresentado e a parte de cima vai ficar transparente !
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  color: Colors.black.withOpacity(0.6),
                )),
                Column(
                  children: [
                    ///Text.rich para conseguirmos colocar padding em dois textos ao mesmo tempo
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Text.rich(
                        TextSpan(
                          text: title,
                          style: TextStyles.buttonBoldHeading,
                          children: [
                            TextSpan(
                                text: '\n$subTitle',
                                style: TextStyles.buttonHeading)
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Container(height: 1, color: AppColors.shape),

                    ///Lembra que componetizamos esses botões, então é usado para mais de uma tela
                    SetLabelButtons(
                        enablePrimaryColor: true,
                        primaryLabel: primaryLabel,
                        primaryOnPressed: primaryOnPressed,
                        secundaryLabel: secundaryLabel,
                        secundaryOnPressed: secundaryOnPressed),
                    SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
