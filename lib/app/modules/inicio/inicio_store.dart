import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:contador_presenca/app/models/local_model.dart';
import 'package:contador_presenca/app/repositories/local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'inicio_store.g.dart';

class InicioStore = _InicioStoreBase with _$InicioStore;

abstract class _InicioStoreBase with Store {
  Barcode? result;
  QRViewController? controller;

  @observable
  bool exibirLeitura = false;

  @observable
  bool status = false;

  final LocalRepository localRepository;

  _InicioStoreBase(this.localRepository);

  void iniciar() async {
    status = await localRepository.initializeDefault();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      salvarId(result!.code);
      Modular.to.pushNamed('/home/');
      if (result!.code!.isNotEmpty) {
        try {
          controller.pauseCamera();
        } catch (e) {
          log(e.toString());
        }
      }
    });
  }

  Future<void> novoLocal(String descricao, limite, BuildContext context) async {
    if (descricao == '') {
      Flushbar(
        title: "Descrição inválida!",
        message: "Preencha o campo descrição e tente novamente.",
        duration: const Duration(seconds: 3),
      ).show(context);
      return;
    }
    if (limite == '' || int.parse(limite) < 1) {
      Flushbar(
        title: "Limite inválido!",
        message: "Preencha o campo limite e tente novamente.",
        duration: const Duration(seconds: 3),
      ).show(context);
      return;
    }
    LocalModel local = LocalModel(
      contador: 0,
      data: DateTime.now().toString(),
      descricao: descricao,
      limite: int.parse(limite),
    );
    try {
      String? res = await localRepository.addLocal(local);
      if (res == 'ERRO') {
        Flushbar(
          title: "Ocorreu um erro ao adicionar!",
          message: "Verifique a sua conexão com a internet e tente novamente.",
          duration: const Duration(seconds: 3),
        ).show(context);
      } else {
        await salvarId(res);
        Modular.to.pushNamed('/home/');
      }
    } catch (e) {
      log(e.toString());
      Flushbar(
        title: "Ocorreu um erro ao adicionar!",
        message: "Verifique a sua conexão com a internet e tente novamente.",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
    Modular.to.pop();
  }

  salvarId(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
  }
}
