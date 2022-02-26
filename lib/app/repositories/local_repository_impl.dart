import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contador_presenca/app/models/local_model.dart';
import 'package:contador_presenca/app/repositories/local_repository.dart';
import 'package:firebase_core/firebase_core.dart';

class LocalRepositoryImpl implements LocalRepository {
  @override
  Future<String> addLocal(LocalModel local) async {
    CollectionReference users = FirebaseFirestore.instance.collection('local');
    String res = "";
    await users
        .add({
          'descricao': local.descricao,
          'limite': local.limite,
          'contador': local.contador,
          'data': local.data
        })
        .then((value) => res = value.id)
        .catchError((error) => res = "ERRO");
    return res;
  }

  @override
  Future<String> cleanContador(String id) async {
    String res = "";
    try {
      DocumentReference local =
          FirebaseFirestore.instance.collection('local').doc(id);

      await local
          .update({'contador': 0})
          .then((value) => res = "OK")
          .catchError((error) => res = "ERRO");
    } catch (e) {
      log(e.toString());
      res = 'ERRO';
    }

    return res;
  }

  @override
  Future<String> delete(String id) async {
    String res = "";
    try {
      DocumentReference local =
          FirebaseFirestore.instance.collection('local').doc(id);
      await local
          .delete()
          .then((value) => res = "OK")
          .catchError((error) => res = "ERRO");
    } catch (e) {
      log(e.toString());
      res = 'ERRO';
    }

    return res;
  }

  @override
  Stream getLocal(String id) {
    Stream local =
        FirebaseFirestore.instance.collection('local').doc(id).snapshots();

    return local;
  }

  @override
  Future<bool> initializeDefault() async {
    try {
      FirebaseApp app = await Firebase.initializeApp();
      log('Inicializado: ' + app.toString());
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<String> updateContador(
      {required String id, required int valor}) async {
    String res = "";
    try {
      DocumentReference local =
          FirebaseFirestore.instance.collection('local').doc(id);
      await local
          .update({'contador': FieldValue.increment(valor)})
          .then((value) => res = "OK")
          .catchError((error) => res = "ERRO");
    } catch (e) {
      log(e.toString());
      res = 'ERRO';
    }
    return res;
  }

  @override
  Future<String> updateLimite({required int limite, required String id}) async {
    String res = "";
    try {
      DocumentReference local =
          FirebaseFirestore.instance.collection('local').doc(id);
      await local
          .update({'limite': limite})
          .then((value) => res = "OK")
          .catchError((error) => res = "ERRO");
    } catch (e) {
      log(e.toString());
      res = 'ERRO';
    }

    return res;
  }
}
