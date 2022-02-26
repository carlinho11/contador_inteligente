import 'dart:developer';

import 'package:contador_presenca/app/modules/home/home_store.dart';
import 'package:contador_presenca/app/modules/home/widgets/dialog_clean_contador.dart';
import 'package:contador_presenca/app/modules/home/widgets/dialog_sair.dart';
import 'package:contador_presenca/app/modules/home/widgets/dialog_update_limite.dart';
import 'package:contador_presenca/app/shared/ui/app_ui.dart';
import 'package:contador_presenca/app/shared/ui/graficos/circulo.dart';
import 'package:contador_presenca/app/shared/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  void initState() {
    store.iniciar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppUi.corFundo,
      body: WillPopScope(
        onWillPop: () => showDialogSair(context),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Observer(builder: (_) {
              if (store.status) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => showDialogSair(context),
                          child: Container(
                            padding: const EdgeInsets.only(right: 20),
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top + 2),
                            color: Colors.transparent,
                            width: size.width * .2,
                            height: size.width * .2,
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 30,
                              color: AppUi.corPrincipal.withOpacity(0.2),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: size.width * .1),
                          height: size.width * .8,
                          width: size.width * .6,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(size.width * .015),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      blurRadius: 20,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: QrImage(
                                  data: controller.id,
                                  version: QrVersions.auto,
                                  size: size.width * .5,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Para adicionar um novo celular, leia o QR Code através dele.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Observer(builder: (_) {
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
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        showDialogUpdateLimite(context),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                        right: 20,
                                        left: 20,
                                        top: 20,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () =>
                                            showDialogCleanContador(context),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                            right: 20,
                                            left: 20,
                                            top: 20,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              StreamBuilder(
                                stream: controller.localRepository
                                    .getLocal(store.id),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: Text(
                                        "Ocorreu um Erro!",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }

                                  try {
                                    store.limite = snapshot.data['limite'];
                                    store.contador = snapshot.data['contador'];
                                    if (snapshot.data['contador'] <
                                        snapshot.data['limite']) {
                                      return SizedBox(
                                        height: size.width * .55,
                                        width: size.width * .55,
                                        child: CustomPaint(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${snapshot.data['contador']}/${snapshot.data['limite']}",
                                                textAlign: TextAlign.end,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  //fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Text(
                                                "PESSOAS",
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                          foregroundPainter: Circulo(
                                            valoresPorcentagem:
                                                store.porcentagens(
                                                    snapshot.data['contador'] ??
                                                        0,
                                                    snapshot.data['limite'] ??
                                                        0),
                                            cores: [
                                              const Color(0xff1f4462),
                                              const Color(0xff224b6d),
                                            ],
                                            largura: 15,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox(
                                        height: size.width * .55,
                                        width: size.width * .55,
                                        child: CustomPaint(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${snapshot.data['contador']}/${snapshot.data['limite']}",
                                                textAlign: TextAlign.end,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                  color: AppUi.corSecundaria,
                                                ),
                                              ),
                                              const Text(
                                                "LOTADO",
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: AppUi.corSecundaria,
                                                ),
                                              ),
                                            ],
                                          ),
                                          foregroundPainter: Circulo(
                                            valoresPorcentagem:
                                                store.porcentagens(
                                                    snapshot.data['contador'] ??
                                                        0,
                                                    snapshot.data['limite'] ??
                                                        0),
                                            cores: [
                                              AppUi.corSecundaria,
                                              AppUi.corPrincipal,
                                            ],
                                            largura: 15,
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    log(e.toString());

                                    return const Center(
                                      child: Text(
                                        "Ocorreu um Erro!",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AppButton(
                                      height: 60,
                                      width: 200,
                                      onPressed: () => store.contarAdd(context),
                                      icone: const Icon(
                                        Icons.done_outline,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    AppButton(
                                      height: 50,
                                      width: 150,
                                      color: Color(0xff1f4462),
                                      colorPress: AppUi.corPrincipal,
                                      onPressed: () =>
                                          store.contarRemover(context),
                                      icone: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
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
        ),
      ),
    );
  }
}
