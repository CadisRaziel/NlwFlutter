import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow/modules/barcode_scaneer/barcode_status.dart';

class BarcodeScannerController {
  ///criando a gerencia de estado com valueNotificer evitamos o setState nas outras telas
  final statusNotifier =
      ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());

  ///quando criamos um ValueNotifier que nem acima, precisamos criar um get e set !
  BarcodeScannerStatus get status => statusNotifier.value;
  set status(BarcodeScannerStatus status) => statusNotifier.value = status;

  ///essa variavel final tem no package do Google_ml_kit
  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  InputImage? imagePicker;

  ///Variavel que vai fazer o controller da nossa camera ou seja, para podermos acessar os recursos da camera
  CameraController? cameraController;

  ///verificando se o celular tem cameras disponiveis
  ///porque isso? as vezes ele ta usando a camera em outro app
  void getAvailableCamreas() async {
    try {
      ///availableCameras = existe dentro do package de camera (ele devolve uma lista de cameras)
      final response = await availableCameras();

      ///fazendo um filtro na lista de cameras acima /\ (e tambem para usarmos a camera traseira apenas)
      ///e porque firstWhere pois as vezes o celular tem mais de uma camera traseira, com isso pegamos a primeira camera
      final camera = response.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back);

      ///vamos instanciar a cameraController para que a camera esteja em resolução maxima e sem audio !
      cameraController =
          CameraController(camera, ResolutionPreset.max, enableAudio: false);

      ///Para inicializar a camera
      await cameraController!.initialize();

      scanWithCamera();
      listenCamera();
    } catch (e) {
      ///repare na utilização do factory criado em BarcodeScannerStatus!!!!
      status = BarcodeScannerStatus.error(e.toString());
    }
  }

  ///função para pegar imagens da galeria com o package ImagePicker
  void scanWithImagePicker() async {
    ///vai esperar a imagem vinda da galeria
    final response = await ImagePicker().getImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);

    ///vai fazer o scanner da imagem caso der tudo certo, se nao cai no else e tenta novamente com o 'getAvailableCameras()'
    scannerBarCode(inputImage);
  }

  void scanWithCamera() {
    ///tivemos que instanciar a classe BarcodeScannerStatus la em cima pois:
    ///tinhamos que colocar o cameraController dentro do facotry criado la
    ///e nao podiamos criar uma 'final' aqui pois ela sempre é reatribuida
    ///repare na utilização do factory criado em BarcodeScannerStatus!!!!
    status = BarcodeScannerStatus.available();

    Future.delayed(Duration(seconds: 20)).then((value) {
      if (status.hasBarcode == false)
        status = BarcodeScannerStatus.error('Timeout da leitura de boleto');
    });
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      ///processamneto da imagem
      final barcodes = await barcodeScanner.processImage(inputImage);

      ///se ele achar o barcode apos processar a imagem
      ///o for ele vai retornar varias listas de barcode que ele encontrou
      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }

      ///se o barcode for diferente de nulo e ele estiver vazio quer dizer que podemos atualizar o status dele
      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.barcode(barcode);

        ///e depois vamos fechar a camera pois vamos navegar para outra tela
        cameraController!.dispose();

        await barcodeScanner.close();
      }

      return;
    } catch (e) {
      print('ERRO DA LEITURA $e');
    }
  }

  ///função para ouvir a imagem que da vindo da camera
  ///pois quando estamos com a camera do QR code aberto no momento em que vamos passando
  /// ele vai tentando ler aquele code incansavelmente e no momento que le ele trava e manda a chamada para o reconhecimento
  void listenCamera() {
    ///todo o codigo criado dentro dessa função esta na doc do google_ml_kit = https://pub.dev/packages/google_ml_kit
    ///esta igualzinho la
    ///lembrando isso é Machine Learning

    ///sempre que criamos o cameraController nos conseguimos verificar se tem alguem ouvindo essa imagem
    if (cameraController!.value.isStreamingImages == false)

      ///se nao tiver ninguem ouvindo essa imagem nós vamos startar o cameraImage
      cameraController!.startImageStream((cameraImage) async {
        if (status.stopScanner == false) {
          try {
            final WriteBuffer allBytes = WriteBuffer();
            for (Plane plane in cameraImage.planes) {
              ///vai criando um array de byte
              allBytes.putUint8List(plane.bytes);
            }

            ///transforma em bytes
            final bytes = allBytes.done().buffer.asUint8List();

            ///tamanho da imagem
            final Size imageSize = Size(
                cameraImage.width.toDouble(), cameraImage.height.toDouble());

            ///rotação que a imagem esta
            final InputImageRotation imageRotation =
                InputImageRotation.Rotation_0deg;

            ///tenta formatar em raw e nao conseguir usa o NV21
            final InputImageFormat inputImageFormat =
                InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
                    InputImageFormat.NV21;

            ///transforma o planeData em uma lista
            final planeData = cameraImage.planes.map(
              (Plane plane) {
                return InputImagePlaneMetadata(
                    bytesPerRow: plane.bytesPerRow,
                    height: plane.height,
                    width: plane.width);
              },
            ).toList();

            final inputeImageData = InputImageData(
                size: imageSize,
                imageRotation: imageRotation,
                inputImageFormat: inputImageFormat,
                planeData: planeData);

            final inputImageCamera = InputImage.fromBytes(
                bytes: bytes, inputImageData: inputeImageData);

            ///colocamos um delay para chamar a proxima função scannerBarCode
            await Future.delayed(Duration(seconds: 3));

            scannerBarCode(inputImageCamera);
          } catch (e) {
            print(e);
          }
        }
      });
  }

  void dispose() {
    ///vai fechar tudo que abrimos
    statusNotifier.dispose();
    barcodeScanner.close();

    ///verifica se a camera ta aberta e fecha ela
    if (status.showCamera) {
      cameraController!.dispose();
    }
  }
}
