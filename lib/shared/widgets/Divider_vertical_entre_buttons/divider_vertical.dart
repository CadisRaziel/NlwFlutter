import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';


///widiget criado para colocar uma barra cinza entre os botões !!!
///e tambem quando clicarmos em um dos botões a animação de clique laranja fique somente no que clicarmos sem invadir o outro
class DividerEntreButtonsWidget extends StatelessWidget {
  const DividerEntreButtonsWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: double.infinity,
      color: AppColors.shape,      
    );
  }
}