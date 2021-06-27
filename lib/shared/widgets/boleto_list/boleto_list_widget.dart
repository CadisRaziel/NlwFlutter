import 'package:flutter/material.dart';

import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto_list/bolleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';

class BoletoListWideget extends StatefulWidget {
  final BoletoListController controller;
  BoletoListWideget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _BoletoListWidegetState createState() => _BoletoListWidegetState();
}

class _BoletoListWidegetState extends State<BoletoListWideget> {
  ///com o código abaixo teremos nosso boletos carregados automaticamente

  @override
  Widget build(BuildContext context) {
    ///depois de realizar o controller e fazer um ValueNotifier la dentro
    ///precisamos colocar o ValueListenableBuilder para ele ouvir aquele valueNotifier
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: widget.controller.boletosNotifier,
      builder: (context, boletos,__) => Column(
        children: boletos
            .map((boletinhos) => BoletoTileWidget(data: boletinhos))
            .toList(),
      ),
    );
  }
}

///(_, boletos, __) = o primeiro underline a gente ignora o primeiro comando, (ao invez de colocar context)
///(_, boletos, __) = vamos no segundo comando pegar o boletos
///(_, boletos, __) = no terceiro underline que é duplo vamos ignorar o  terceiro comando (ao invez de colocar widget)
