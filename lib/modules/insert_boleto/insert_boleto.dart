import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_style.dart';
import 'package:payflow/shared/widgets/BottonNAV_Widget_buttons_scannerPage/set_label_buttons.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';

class InsertBoletoPage extends StatefulWidget {
  const InsertBoletoPage({ Key? key }) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 93, vertical: 24),
              child: Text('Preencha os dados do boleto', style: TextStyles.titleBoldHeading, textAlign: TextAlign.center,),
            ),
            InputTextWidget(
              label: 'Nome do boleto',
              icon: Icons.description_outlined,
              onChanged: (value){},
            ),
            InputTextWidget(
              label: 'Vencimento',
              icon: FontAwesomeIcons.timesCircle,
              onChanged: (value){},
            ),
            InputTextWidget(
              label: 'Valor',
              icon: FontAwesomeIcons.wallet,
              onChanged: (value){},
            ),
            InputTextWidget(
              label: 'Código',
              icon: FontAwesomeIcons.barcode,
              onChanged: (value){},
            ),
          ],
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryLabel: 'Cancelar',
        primaryOnPressed: (){
          Navigator.pop(context);
        }, 
        enableSecundaryColor: true,
        secundaryLabel: 'Cadastrar', 
        secundaryOnPressed: (){}
        ),
    );
  }
}