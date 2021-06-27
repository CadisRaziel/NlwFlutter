import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_style.dart';

class BoletoInfoWidget extends StatelessWidget {
  final int qtdBoletos;
  const BoletoInfoWidget({
    Key? key,
    required this.qtdBoletos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              AppImages.logomini,
              color: AppColors.background,
              width: 56,
              height: 34,
            ),

            ///esse container tem aquele risco separando codigo de barras do texto
            Container(
              width: 1,
              height: 32,
              color: AppColors.background,
            ),

            Text.rich(
              TextSpan(
                text: 'Você tem ',
                style: TextStyles.captionBackground,
                children: [
                  TextSpan(
                      text: '$qtdBoletos boletos\n',
                      style: TextStyles.captionBoldBackground),
                  TextSpan(
                      text: 'cadastrados para pagar',
                      style: TextStyles.captionBackground)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
