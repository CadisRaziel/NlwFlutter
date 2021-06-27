class BarcodeScannerStatus {
  ///gerenciando o estado da camera !

  ///isCameraAvailable = a camera esta pronta ?
  final bool isCameraAvailable;

  ///error = se tiver algum erro vamos armazenar ele
  final String error;

  ///barcode = se tiver o barcode a gente vai armazenar ele
  final String barcode;

  ///variavel para dar um stop no scanner
  final bool stopScanner;


  BarcodeScannerStatus(
      {this.isCameraAvailable = false,
      this.error = '',
      this.barcode = '',
      this.stopScanner = false});

  /*Factory é um construtor nomeado,
   além do construtor padrão, você pode ter vários tipos para criar sua classe,
   por isso usamos o factory para definir que queríamos mais um para fazer o fromJson e fromMap
  */
  factory BarcodeScannerStatus.available() =>
      BarcodeScannerStatus(
          isCameraAvailable: true, stopScanner: false);

  ///quando der erro ele para o scanner
  factory BarcodeScannerStatus.error(String message) =>
      BarcodeScannerStatus(error: message, stopScanner: true);

  ///e quando encontrarmos o barcode queremos parar o scanner
  factory BarcodeScannerStatus.barcode(String barcode) =>
      BarcodeScannerStatus(barcode: barcode, stopScanner: true);

  ///Só vamos exibir a camera se ela estiver pronta e não tiver nenhum tipo de erro
  bool get showCamera => isCameraAvailable && error.isEmpty;

  ///se tiver algum erro vai verificar ele e tomar uma decição
  bool get hasError => error.isNotEmpty;

  ///só vamos saber se tem o barcode se ele não estiver vazio
  bool get hasBarcode => barcode.isNotEmpty;
}
