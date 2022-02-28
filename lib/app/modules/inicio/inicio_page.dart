import 'dart:developer';

import 'package:contador_presenca/app/modules/inicio/widgets/dialog_novo_local.dart';
import 'package:contador_presenca/app/shared/ui/app_ui.dart';
import 'package:contador_presenca/app/shared/ui/widgets/app_button.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:contador_presenca/app/modules/inicio/inicio_store.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class InicioPage extends StatefulWidget {
  final String title;
  const InicioPage({Key? key, this.title = 'InicioPage'}) : super(key: key);
  @override
  InicioPageState createState() => InicioPageState();
}

class InicioPageState extends State<InicioPage> {
  final InicioStore store = Modular.get();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    store.iniciar();
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    store.controller?.pauseCamera();
    store.controller?.resumeCamera();
  }

  @override
  void dispose() {
    store.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppUi.corFundo,
      body: SingleChildScrollView(
        child: Observer(builder: (_) {
          if (store.exibirLeitura) {
            return Container(
              padding: EdgeInsets.only(
                  top: 20 + MediaQuery.of(context).padding.top,
                  right: 20,
                  bottom: 20,
                  left: 20),
              width: size.width,
              color: AppUi.corPrincipal,
              height: size.height,
              child: Column(
                children: [
                  Expanded(
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: store.onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: AppUi.corPrincipal,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        //cutOutSize: scanArea,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppButton(
                    label: 'Voltar',
                    height: 55,
                    width: 180,
                    onPressed: () async {
                      try {
                        store.controller?.pauseCamera();
                      } catch (e) {
                        log(e.toString());
                      }
                      store.exibirLeitura = false;
                    },
                    icone: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.width * .2,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: size.width * .1),
                    height: size.width * .4,
                    width: size.width * .35,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: AssetImage("img/logo.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: size.width * .2,
                    width: size.width * .7,
                    child: Column(
                      children: const [
                        Text(
                          "Contador Inteligente",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppUi.corPrincipal,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Controle o fluxo de pessoas através de vários dispositivos sincronizados em tempo real",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Observer(builder: (_) {
                      if (store.status) {
                        return Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ),
                            color: AppUi.corPrincipal,
                          ),
                          width: size.width,
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.width * .18,
                              ),
                              AppButton(
                                label: 'Ler QR Code',
                                height: 60,
                                width: 200,
                                onPressed: () => store.exibirLeitura = true,
                                icone: const Icon(
                                  Icons.qr_code_2_rounded,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              SizedBox(
                                height: size.width * .12,
                              ),
                              AppButton(
                                label: 'Novo Local',
                                height: 60,
                                width: 200,
                                onPressed: () => showDialogNovoLocal(context),
                                icone: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppUi.corPrincipal,
                            strokeWidth: 2,
                          ),
                        );
                      }
                    }),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
