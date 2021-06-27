import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

///responsavel por buscar os boletos e apresentar na lista

///vamos instanciar la no boleto_list_widget
class BoletoListController{

  ///para fazer as notificações automaticas
  ///(<BoletoModel>[]); = inicialização da lista será vazia !
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);


  ///get vai pegar os boletos
  ///set vai atualizar os dados
  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  ///ao invez de chamar la no boleto_list_widget em uma initState
  ///e toda vez que a gente instanciar o BoletosListController ele ja vai dar a função getBoletos para nós 
  BoletoListController(){
    getBoletos();
  }

  Future<void> getBoletos() async {
    try {
      final instance = await SharedPreferences.getInstance();

      /// ??  <String>[]; = caso vier vazio, para nao der erro no boletos = response.map
      final response = instance.getStringList("boletos") ?? <String>[];
      boletos = response.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }
}