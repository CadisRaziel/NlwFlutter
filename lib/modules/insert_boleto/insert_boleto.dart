import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_style.dart';
import 'package:payflow/shared/widgets/BottonNAV_Widget_buttons_scannerPage/set_label_buttons.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({
    Key? key,
    this.barcode,
  }) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  ///instanciando as validações
  final controller = InsertBoletoController();

  ///aqui vamos colocar uma mask no dinheiro
  final moneyInputTextController =
      MoneyMaskedTextController(leftSymbol: "R\$", decimalSeparator: ",");

  ///aqui vamos colocar uma mask na data de vencimento
  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");

  ///quando a gente chamar a pagina InsertBoletoPage e se ele conter um valor inicial nos vamos colocar para dentro do barcode
  final barcodeInputTextController = TextEditingController();

  ///quando lermos o leitor ele ja vai aparecer o codigo diretamente no input do 'código'
  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,

        ///Elevation = isso é muito maneiro, sabe aquela linha abaixo do appBar? com o elevation conseguimos tirar
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 93, vertical: 24),
                child: Text(
                  'Preencha os dados do boleto',
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                ///olha que legal colocamos o Form envolvendo os botões e inserimos a key
                ///que criamos la no controller para que o flutter gerencie as validações
                key: controller.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      ///repare que vamos inserir as validações aqui(elas estao criadas no InsertBoletoController) e instanciamos ele ali em cima
                      validator: controller.validateName,
                      label: 'Nome do boleto',
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        controller.onChange(name: value);
                      },
                    ),
                    InputTextWidget(
                      validator: controller.validateVencimento,
                      controller: dueDateInputTextController,
                      label: 'Vencimento',
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        controller.onChange(dueDate: value);
                      },
                    ),
                    InputTextWidget(
                      validator: (_) => controller
                          .validateValor(moneyInputTextController.numberValue),
                      controller: moneyInputTextController,
                      label: 'Valor',
                      icon: FontAwesomeIcons.wallet,
                      onChanged: (value) {
                        controller.onChange(value: moneyInputTextController.numberValue); 
                      },
                    ),
                    InputTextWidget(
                      validator: controller.validateCodigo,
                      controller: barcodeInputTextController,
                      label: 'Código',
                      icon: FontAwesomeIcons.barcode,
                      onChanged: (value) {
                        controller.onChange(barcode: value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
          primaryLabel: 'Cancelar',
          primaryOnPressed: () {
            Navigator.pop(context);
          },
          enableSecundaryColor: true,
          secundaryLabel: 'Cadastrar',
          secundaryOnPressed: () async {
           await controller.cadastrarBoleto();
            Navigator.pop(context);
          }),
    );
  }
}
