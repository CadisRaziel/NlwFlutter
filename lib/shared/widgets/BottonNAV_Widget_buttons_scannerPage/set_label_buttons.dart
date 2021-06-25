import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_style.dart';

import 'package:payflow/shared/widgets/Divider_vertical_entre_buttons/divider_vertical.dart';
import 'package:payflow/shared/widgets/labelButton/label_button.dart';

///Widget criado para componetizar os buttons do BottonNavigator da 'BarcodeScannerPage'
///fizemos isso pois vamos usar eles em mais de uma tela ! e cada tela ele vai ter seu nome proprio e sua função
class SetLabelButtons extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secundaryLabel;
  final VoidCallback secundaryOnPressed;
  final bool enablePrimaryColor;
  final bool enableSecundaryColor;

  const SetLabelButtons({
    Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secundaryLabel,
    required this.secundaryOnPressed,
    this.enablePrimaryColor = false,
    this.enableSecundaryColor = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      ///Envolvemos os botões em um Container para que o DividerEntreButtonsWidget não ocupe a tela toda !!
      height: 57,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 1,
            height: 1,
            color: AppColors.stroke,
          ),
          Container(
            height: 56,
            child: Row(
              children: [
                Expanded(
                  child: LabelButton(
                    label: primaryLabel,
                    onPressed: primaryOnPressed,
                    style: enablePrimaryColor ? TextStyles.buttonPrimary : null,
                  ),
                ),
                DividerEntreButtonsWidget(),
                Expanded(
                  child: LabelButton(
                    label: secundaryLabel,
                    onPressed: secundaryOnPressed,
                    style: enableSecundaryColor ? TextStyles.buttonPrimary : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
