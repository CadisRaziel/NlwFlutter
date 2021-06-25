import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scaneer/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scaneer/barcode_status.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_style.dart';
import 'package:payflow/shared/widgets/BottonNAV_Widget_buttons_scannerPage/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    ///Anets de renderizar qualqeur coisa na tela ele vai chamar as cameras
    controller.getAvailableCamreas();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///codigo criado para criar a tela BottomSheetWidget
    // return BottomSheetWidget(
    //   title: "Não foi possivel idenfiticar um código de barras.",
    //   subTitle: "Tente escanear novamente ou digite o código do seu boleto",
    //   primaryLabel: "Escanear novamente",
    //   primaryOnPressed: (){},
    //   secundaryLabel: "Digitar código",
    //   secundaryOnPressed: (){},
    // );

    ///SafeAre para evitar que ele fique em cima do icone de bateria, notificação, hora, nas bordas e nos botóes de celulares antigos
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,

      ///Stack para colocarmos a camera por baixo dos widgets abaixo
      child: Stack(
        children: [
          ///Para ver as mudanças que acontece la no barcode_sacnner_controller
          ///ValueListenableBuilder é tipo um setState porém ele procura um ValueNotifier que foi criado em barcode_scanner_controller
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              ///caso ele pode exibir a camera retornarmos um container
              if (status.showCamera) {
                return Container(
                  child: status.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),

          ///RotatedBox = para rotacionar a tela
          ///quarterTurns: 0 -> nao gira a tela
          ///quarterTurns: 1 -> gira a tela em 90 graus
          ///usado para que o usuario nao tenha que ficar ativando rotação de tela, mesmo desativado a rotação ele vai rodar 90 graus !
          ///evita problemas com a camera !!! otima solução pois gira somente o WIDGET
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    'Escaneie o código de barras do boleto',
                    style: TextStyles.buttonBoldBackground,
                  ),
                  centerTitle: true,

                  ///Quando colocamos brackground a setinha de voltar some, para isso adicionamos o BackButton e pronto!
                  leading: BackButton(
                    color: AppColors.background,
                  ),
                ),

                ///Aqui criaremos uma Column para criar a parte que a camera escaneia, a parte dos botoes e o titulo do appbar
                body: Column(
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.black.withOpacity(0.6),
                    )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.transparent,
                        )),
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: SetLabelButtons(
                  primaryLabel: "Inserir código do boleto",
                  primaryOnPressed: () {},
                  secundaryLabel: "Adicionar da geleria",
                  secundaryOnPressed: () {},
                )),
          ),
        ],
      ),
    );
  }
}
