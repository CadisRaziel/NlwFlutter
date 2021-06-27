import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/core/App_widget.dart';


/* 
WidgetsFlutterBinding.ensureInitialized(); ->
Se você estiver executando um aplicativo e precisar acessar o mensageiro binário antes de runApp() 
ser chamado (por exemplo, durante a inicialização do plug-in),
será necessário chamar explicitamente o WidgetsFlutterBinding.ensureInitialized()primeiro.
*/
void main() {
  WidgetsFlutterBinding.ensureInitialized();  
  runApp(AppFirebase());
}

///Classe para inicializar o firebase
class AppFirebase extends StatefulWidget {
  const AppFirebase({Key? key}) : super(key: key);

  @override
  _AppFirebaseState createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  ///iniciando o Firebase
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    ///Veja que não precisamos dar um async await, o motivo é que o FutureBuilder tem um async await internamente
    return FutureBuilder(
        // Inicialize o FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          /// Verifique se há erros
          if (snapshot.hasError) {
            return Material(
              child: Center(
                child: Text(
                  'Não foi possivel inicializar o Firebase',
                  textDirection: TextDirection.ltr,
                ),
              ),
            );

            /// Depois de concluído, mostre seu aplicativo
          } else if (snapshot.connectionState == ConnectionState.done) {
            return AppWidget();
          } else {
            ///Caso contrário, mostre algo enquanto aguarda a conclusão da inicialização
            return Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
