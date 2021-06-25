import 'package:camera/camera.dart';

class BarcodeScannerStatus {
  ///gerenciando o estado da camera !

  ///isCameraAvailable = a camera esta pronta ?
  final bool isCameraAvailable;

  ///error = se tiver algum erro vamos armazenar ele
  final String error;

  ///barcode = se tiver o barcode a gente vai armazenar ele
  final String barcode;

  ///Variavel que vai fazer o controller da nossa camera ou seja, para podermos acessar os recursos da camera
  CameraController? cameraController;

  BarcodeScannerStatus(
      {this.isCameraAvailable = false,
      this.error = '',
      this.barcode = '',
      this.cameraController});

  /*Factory é um construtor nomeado,
   além do construtor padrão, você pode ter vários tipos para criar sua classe,
   por isso usamos o factory para definir que queríamos mais um para fazer o fromJson e fromMap
  */
  factory BarcodeScannerStatus.available(CameraController controller) =>
      BarcodeScannerStatus(
          isCameraAvailable: true, cameraController: controller);

  factory BarcodeScannerStatus.error(String message) =>
      BarcodeScannerStatus(error: message);

  factory BarcodeScannerStatus.barcode(String barcode) =>
      BarcodeScannerStatus(barcode: barcode);

  ///Só vamos exibir a camera se ela estiver pronta e não tiver nenhum tipo de erro
  bool get showCamera => isCameraAvailable && error.isEmpty;

  ///se tiver algum erro vai verificar ele e tomar uma decição
  bool get hasError => error.isNotEmpty;

  ///só vamos saber se tem o barcode se ele não estiver vazio
  bool get hasBarcode => barcode.isNotEmpty;
}
