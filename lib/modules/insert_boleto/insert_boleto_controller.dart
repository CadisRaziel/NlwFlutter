import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

///aqui teremos os alertas dos input, caso o usuario não preencher os inputs corretamente vai aparecer essas mensagens !
///OBS: o null no final de cada funcção quer dizer que ta tudo certo( o usuario preencheu )

class InsertBoletoController {
  ///com o formkey o proprio flutter vai fazer as validações
  final formKey = GlobalKey<FormState>();

  BoletoModel model = BoletoModel();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? 'Por favor insira o nome do boleto' : null;
  String? validateVencimento(String? value) => value?.isEmpty ?? true
      ? 'Por favor coloque uma data de vencimento'
      : null;
  String? validateValor(double value) =>
      value == 0 ? 'Insira um valor maior que R\$: 0,00' : null;
  String? validateCodigo(String? value) =>
      value?.isEmpty ?? true ? 'Por favor insira o código do boleto' : null;


  ///função para salvar o boleto
  Future<void> saveBoleto() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final boletos = instance.getStringList("boletos") ?? <String>[];
      boletos.add(model.toJson());
      await instance.setStringList("boletos", boletos);
      return;
    } catch (e) {
      print(e);
    }
  }


  ///função para ter todos os tipos de entrada
  void onChange({String? name, String? dueDate, double? value, String? barcode}){
    ///copyWith = caso passarmos um parametro nulo, ele vai manter o nullo que ja estava salvo
    model = model.copyWith(name: name, dueDate: dueDate, value: value, barcode: barcode);
  }

  ///função que vai verificar se os campos não estão preenchidos, caso não tiver aparece as mensagens criadas acima /\
  Future<void> cadastrarBoleto() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      return saveBoleto();
    }
  }
}

///Quando passamos uma GlobalKey para um Widget (Form)
///Conseguimos pegar o estato atual (currentState) daquele Widget
///e o formKey quando usamos ele e o TextFormField (TextField não funciona), ele sabe que dentro do Form tem um TextFormField
///ai ele vai dentro de cada um deles e chamar a função validator para nós automaticamente
