import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_text_style.dart';

///Vamos componetizar esse labelButton pois ele vai ser usado em mais de uma tela
///lemnrando LabelButton é aquele que deixa um Container inteiro clicavel
class LabelButton extends StatelessWidget {
  ///string label para colocarmos os nomes nas telas em que usarmos ele
  final String label;

  ///VoidCallBack para ter a função do onpPressed em todo lugar que ele ser usado
  final VoidCallback onPressed;

  final TextStyle? style;

  const LabelButton(
      {Key? key, required this.label, required this.onPressed, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Envolvemos esse TextButton em um container pelo seguinte motivo:
    ///adicioanmos o primarySwatch no app_widgets para que quando clicarmos no botão ele de efeito de clique laranja
    ///porém o TextButton sozinho colocava margens
    ///com o Container e colocando o tamanho 'height' ele vai dar o efeito nele inteiro sem margens
    return Container(
      height: 56,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: style ?? TextStyles.buttonBoldHeading,
        ),
      ),
    );
  }
}
