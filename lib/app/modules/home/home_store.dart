import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:contador_presenca/app/repositories/local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  String id = '';

  @observable
  bool status = false;

  int limite = 0;

  int contador = 100;

  final LocalRepository localRepository;

  HomeStoreBase(this.localRepository);

  void iniciar() async {
    await pegarId();
    log('Home:' + id);
  }

  pegarId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? "";
    if (id == '') Modular.to.pop();
    status = true;
  }

  Future<void> deleteLocal(BuildContext context) async {
    try {
      if (await localRepository.delete(id) == "ERRO") {
        Flushbar(
          title: "Ocorreu um erro ao excluir!",
          message: "Verifique a sua conexão com a internet e tente novamente.",
          duration: const Duration(seconds: 3),
        ).show(context);
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Flushbar(
          title: "Local excluído!",
          message: "Local excluído com sucesso.",
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  updateLimite({required String limite, required BuildContext context}) async {
    if (limite.isNotEmpty) {
      if (int.parse(limite) > 0) {
        if (await localRepository.updateLimite(
                limite: int.parse(limite), id: id) ==
            "ERRO") {
          Flushbar(
            title: "Ocorreu um erro ao alterar!",
            message:
                "Verifique a sua conexão com a internet e tente novamente.",
            duration: const Duration(seconds: 3),
          ).show(context);
        }
        Modular.to.pop();
      } else {
        Flushbar(
          title: "Número invalido!",
          message: "Digite um valor valido!",
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    } else {
      Flushbar(
        title: "Número invalido!",
        message: "Digite um valor valido!",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  cleanContador(BuildContext context) async {
    if (await localRepository.cleanContador(id) == "ERRO") {
      Flushbar(
        title: "Ocorreu um erro ao zerar!",
        message: "Verifique a sua conexão com a internet e tente novamente.",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
    Navigator.of(context).pop();
  }

  contarAdd(context) async {
    if (await localRepository.updateContador(id: id, valor: 1) == "ERRO") {
      Flushbar(
        title: "Ocorreu um erro ao contar!",
        message: "Verifique a sua conexão com a internet e tente novamente.",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  contarRemover(context) async {
    if (contador > 0) {
      if (await localRepository.updateContador(id: id, valor: -1) == "ERRO") {
        Flushbar(
          title: "Ocorreu um erro ao contar!",
          message: "Verifique a sua conexão com a internet e tente novamente.",
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    }
  }

  List<double> porcentagens(int contador, limite) {
    if (contador == 0) {
      return [0, 1];
    }
    if ((1 - contador / limite) < 0) {
      return [1, 0];
    }
    return [contador / limite, 1 - contador / limite];
  }
}
